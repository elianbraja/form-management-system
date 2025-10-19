# frozen_string_literal: true

class FieldValue < ApplicationRecord
  belongs_to :form_entry
  belongs_to :form_field

  validates :form_entry_id, uniqueness: { scope: :form_field_id }
  validate :required_field_validation

  private

  def required_field_validation
    return unless form_field.required
    return unless value.blank?

    errors.add(:value, "can't be blank")
  end
end
