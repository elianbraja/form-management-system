# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable

  validates :first_name, presence: true
  validates :last_name, presence: true

  validates :password, format: {
    with: /\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{6,}\z/,
    message: 'must include at least one lowercase letter, one uppercase letter,
              one digit, and one special character'
  }, if: :password_required?

  private

  def password_required?
    !persisted? || !password.nil?
  end
end
