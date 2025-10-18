# frozen_string_literal: true

class FormField < ApplicationRecord
  FIELD_TYPES = %w[string integer datetime].freeze

  belongs_to :form
  has_many :field_values, dependent: :destroy

  validates :name, presence: true
  validates :field_type, presence: true, inclusion: { in: FIELD_TYPES }
end
