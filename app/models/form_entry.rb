# frozen_string_literal: true

class FormEntry < ApplicationRecord
  belongs_to :form
  belongs_to :user
  has_many :field_values, dependent: :destroy

  validates :submitted_at, presence: true

  before_validation :set_submitted_at, on: :create

  private

  def set_submitted_at
    self.submitted_at ||= Time.current
  end
end
