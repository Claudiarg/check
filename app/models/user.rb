class User < ApplicationRecord
  has_secure_password
  acts_as_paranoid
  
  validates :name, :kind, :email, presence: true, length: { maximum: 255 }
  validates :auth_token, uniqueness: true
  validates :email, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :kind, inclusion: { in: %w(admin employee) }

  has_many :checkers
end
