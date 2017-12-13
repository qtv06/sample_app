class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  has_secure_password
  validates :email, presence: true, length: {maximum: Settings.validates.maximum_email},
    format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  validates :name, presence: true, length: {maximum: Settings.validates.maximum_name}
  validates :password, :password_confirmation, presence: true,
    length: {minimum: Settings.validates.minimum_pass}
  before_save{email.downcase!}
end
