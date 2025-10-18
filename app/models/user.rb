# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable

  has_many :forms, dependent: :destroy
  has_many :form_entries, dependent: :destroy

  validates :first_name, presence: true
  validates :last_name, presence: true

  # Simplified password validation for easier testing
  validates :password, length: { minimum: 6 }, if: :password_required?

  private

  def password_required?
    !persisted? || !password.nil?
  end
end
