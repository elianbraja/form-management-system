class FormEntries::CreateService < BaseService
  include FieldValidation

  attribute :form
  attribute :user
  attribute :field_values, default: -> { [] }
  attr_accessor :form_entry

  validates :form, presence: true
  validates :user, presence: true
  validate :validate_field_values

  def initialize(attributes = {})
    super
    @form_entry = nil
    
    # Convert field_values hash to array if needed
    @field_values = normalize_array_or_hash(@field_values)
  end

  protected

  def execute
    @form_entry = create_form_entry
    create_field_values
  end

  private

  def create_form_entry
    FormEntry.create!(
      form: form,
      user: user,
      submitted_at: Time.current
    )
  end

  def create_field_values
    field_values_to_create = normalize_array_or_hash(field_values)

    field_values_to_create.each do |field_value_params|
      next if field_value_params[:value].blank? && !field_required?(field_value_params[:form_field_id])
      
      @form_entry.field_values.create!(
        form_field_id: field_value_params[:form_field_id],
        value: field_value_params[:value]
      )
    end
  end

  def validate_field_values
    if field_values.blank?
      errors.add(:field_values, "must have at least one field value")
      return
    end

    field_values_to_validate = normalize_array_or_hash(field_values)

    field_values_to_validate.each_with_index do |field_value_params, index|
      validate_field_value(field_value_params, index)
    end
  end
end
