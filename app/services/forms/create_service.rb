# frozen_string_literal: true

class Forms::CreateService < BaseService
  include FormFieldValidation

  attribute :title, :string
  attribute :user_id, :integer
  attribute :fields, default: -> { [] }

  validates :title, presence: true
  validates :user_id, presence: true
  validate :validate_fields

  def initialize(attributes = {})
    super
    @form = nil
    
    # Convert fields hash to array if needed
    @fields = normalize_array_or_hash(@fields)
  end

  def form
    @form
  end

  protected

  def execute
    create_form
    create_fields
  end

  private

  def create_form
    @form = Form.create!(
      title: title,
      user_id: user_id
    )
  end

  def create_fields
    # Handle both hash and array formats
    fields_to_create = normalize_array_or_hash(fields)
    
    fields_to_create.each do |field_params|
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
      errors.add(:fields, "must have at least one field")
      return
    end

    # Handle both hash and array formats
    fields_to_validate = normalize_array_or_hash(fields)
    
    fields_to_validate.each_with_index do |field_params, index|
      validate_field(field_params, index)
    end
  end
end
