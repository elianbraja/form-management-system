# frozen_string_literal: true

class BaseService
  include ActiveModel::Model
  include ActiveModel::Attributes

  attr_accessor :errors

  def initialize(attributes = {})
    super
    @errors = ActiveModel::Errors.new(self)
  end

  def call
    return false unless valid?

    ActiveRecord::Base.transaction do
      execute
    end
    true
  rescue ActiveRecord::RecordInvalid => e
    errors.add(:base, e.message)
    false
  end

  protected

  def execute
    raise NotImplementedError, 'Subclasses must implement #execute'
  end

  def normalize_array_or_hash(data)
    return [] if data.blank?

    data.is_a?(Hash) ? data.values : data
  end

  def add_field_errors(field_errors, field_index)
    field_errors.each do |error_message|
      errors.add(:"field_values[#{field_index}]", error_message)
    end
  end
end
