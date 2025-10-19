# frozen_string_literal: true

module FieldValidation
  extend ActiveSupport::Concern

  def validate_field_value(field_value_params, index)
    field_errors = []

    # Check if form_field_id is present
    if field_value_params[:form_field_id].blank?
      field_errors << 'Form field is required'
    else
      form_field = form.form_fields.find_by(id: field_value_params[:form_field_id])

      if form_field.nil?
        field_errors << 'Invalid form field'
      else
        # Check required field validation
        field_errors << "#{form_field.name} is required" if form_field.required? && field_value_params[:value].blank?

        # Check field-specific validations
        validate_field_value_by_type(field_value_params, form_field, field_errors)
      end
    end

    add_field_errors(field_errors, index)
  end

  def validate_field_value_by_type(field_value_params, form_field, field_errors)
    value = field_value_params[:value]
    return if value.blank?

    case form_field.field_type
    when 'string'
      validate_string_field(value, form_field, field_errors)
    when 'integer'
      validate_integer_field(value, form_field, field_errors)
    when 'datetime'
      validate_datetime_field(value, form_field, field_errors)
    end
  end

  def validate_string_field(value, form_field, field_errors)
    validations = form_field.validations

    if validations['min_length'].present? && value.length < validations['min_length'].to_i
      field_errors << "#{form_field.name} must be at least #{validations['min_length']} characters"
    end

    return unless validations['max_length'].present? && value.length > validations['max_length'].to_i

    field_errors << "#{form_field.name} must be no more than #{validations['max_length']} characters"
  end

  def validate_integer_field(value, form_field, field_errors)
    validations = form_field.validations

    # Check if value is a valid integer
    unless value.match?(/^-?\d+$/)
      field_errors << "#{form_field.name} must be a valid number"
      return
    end

    int_value = value.to_i

    if validations['min_value'].present? && int_value < validations['min_value'].to_i
      field_errors << "#{form_field.name} must be at least #{validations['min_value']}"
    end

    return unless validations['max_value'].present? && int_value > validations['max_value'].to_i

    field_errors << "#{form_field.name} must be no more than #{validations['max_value']}"
  end

  def validate_datetime_field(value, form_field, field_errors)
    # Basic datetime validation - could be enhanced

    DateTime.parse(value)
  rescue ArgumentError
    field_errors << "#{form_field.name} must be a valid date and time"
  end

  def field_required?(form_field_id)
    form_field = form.form_fields.find_by(id: form_field_id)
    form_field&.required?
  end
end
