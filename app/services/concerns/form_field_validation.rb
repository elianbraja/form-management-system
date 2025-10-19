# frozen_string_literal: true

module FormFieldValidation
  extend ActiveSupport::Concern

  def validate_field(field_params, index)
    field_errors = []

    # Required validations
    field_errors << "Name is required" if field_params[:name].blank?
    field_errors << "Field type is required" if field_params[:field_type].blank?

    # Field type validation
    unless FormField::FIELD_TYPES.include?(field_params[:field_type])
      field_errors << "Invalid field type"
    end

    # Type-specific validations
    case field_params[:field_type]
    when 'string'
      if field_params[:min_length].present? && field_params[:max_length].present?
        if field_params[:min_length].to_i > field_params[:max_length].to_i
          field_errors << "Minimum length cannot be greater than maximum length"
        end
      end
    when 'integer'
      if field_params[:min_value].present? && field_params[:max_value].present?
        if field_params[:min_value].to_i > field_params[:max_value].to_i
          field_errors << "Minimum value cannot be greater than maximum value"
        end
      end
    end

    # Add errors with field index
    field_errors.each do |error|
      errors.add(:fields, "Field #{index + 1}: #{error}")
    end
  end

  def build_validations(field_params)
    validations = {}
    
    case field_params[:field_type]
    when 'string'
      validations[:min_length] = field_params[:min_length].to_i if field_params[:min_length].present?
      validations[:max_length] = field_params[:max_length].to_i if field_params[:max_length].present?
    when 'integer'
      validations[:min_value] = field_params[:min_value].to_i if field_params[:min_value].present?
      validations[:max_value] = field_params[:max_value].to_i if field_params[:max_value].present?
    end

    validations
  end
end
