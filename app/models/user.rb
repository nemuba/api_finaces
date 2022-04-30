class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true
  validates :password, length: { minimum: 6, maximum: 12 }
  validates :name, presence: true

  api_guard_associations refresh_token: 'refresh_tokens', blacklisted_token: 'blacklisted_tokens'
  has_many :refresh_tokens, dependent: :delete_all

  api_guard_associations blacklisted_token: 'blacklisted_tokens'
  has_many :blacklisted_tokens, dependent: :delete_all

  has_one :balance
end
