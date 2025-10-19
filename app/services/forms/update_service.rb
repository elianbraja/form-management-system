# frozen_string_literal: true

module Forms
  class UpdateService < BaseService
    include FormFieldValidation

    attribute :title, :string
    attribute :fields, default: -> { [] }

    validates :title, presence: true
    validate :validate_fields

    def initialize(form, attributes = {})
      @form = form
      super(attributes)

      # If no fields provided, populate from existing form fields
      populate_existing_fields if fields.empty?
    end

    attr_reader :form

    protected

    def execute
      update_form
      update_fields
    end

    private

    def populate_existing_fields
      self.fields = @form.form_fields.map do |field|
        {
          name: field.name,
          field_type: field.field_type,
          required: field.required,
          min_length: field.validations['min_length'],
          max_length: field.validations['max_length'],
          min_value: field.validations['min_value'],
          max_value: field.validations['max_value']
        }
      end
    end

    def update_form
      @form.update!(title: title)
    end

    def update_fields
      # Handle both hash and array formats
      fields_to_update = normalize_array_or_hash(fields)

      # Remove existing fields
      @form.form_fields.destroy_all

      # Create new fields
      fields_to_update.each do |field_params|
        @form.form_fields.create!(
          name: field_params[:name],
          field_type: field_params[:field_type],
          required: field_params[:required] || false,
          validations: build_validations(field_params)
        )
      end
    end

    def validate_fields
      if fields.empty?
        errors.add(:fields, 'must have at least one field')
        return
      end

      # Handle both hash and array formats
      fields_to_validate = normalize_array_or_hash(fields)

      fields_to_validate.each_with_index do |field_params, index|
        validate_field(field_params, index)
      end
    end
  end
end
