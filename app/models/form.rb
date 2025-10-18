# frozen_string_literal: true

class Form < ApplicationRecord
  belongs_to :user
  has_many :form_fields, dependent: :destroy
  has_many :form_entries, dependent: :destroy

  validates :title, presence: true

  # Check if form can be edited (no entries exist)
  def editable?
    form_entries.empty?
  end

  # Check if form has entries (locked for editing)
  def locked?
    form_entries.any?
  end
end
