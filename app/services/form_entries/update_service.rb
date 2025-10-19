# frozen_string_literal: true

module FormEntries
  class UpdateService < BaseService
    include FieldValidation

    attribute :form_entry
    attribute :form
    attribute :user
    attribute :field_values, default: -> { [] }

    validates :form_entry, presence: true
    validates :form, presence: true
    validates :user, presence: true
    validate :validate_field_values

    def initialize(attributes = {})
      super
      # Convert field_values hash to array if needed
      @field_values = normalize_array_or_hash(@field_values)
    end

    protected

    def execute
      update_field_values
    end

    private

    def update_field_values
      field_values_to_update = normalize_array_or_hash(field_values)

      field_values_to_update.each do |field_value_params|
        form_field_id = field_value_params[:form_field_id]
        value = field_value_params[:value]

        # Find existing field value or create new one
        field_value = form_entry.field_values.find_or_initialize_by(form_field_id: form_field_id)

        if value.present? || field_required?(form_field_id)
          field_value.value = value
          field_value.save!
        elsif field_value.persisted?
          field_value.destroy!
        end
      end
    end

    def validate_field_values
      if field_values.blank?
        errors.add(:field_values, 'must have at least one field value')
        return
      end

      field_values_to_validate = normalize_array_or_hash(field_values)

      field_values_to_validate.each_with_index do |field_value_params, index|
        validate_field_value(field_value_params, index)
      end
    end
  end
end
