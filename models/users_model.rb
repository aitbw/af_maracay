require 'active_support/core_ext/string/inflections'

# Model for 'users' table
class User < ActiveRecord::Base
  after_validation :encrypt_password, on: :create
  after_validation :normalize_name
  has_many :signups, dependent: :destroy
  has_many :fees, dependent: :destroy

  validates :user_name, presence: true
  validates :user_cedula, presence: true, uniqueness: true, numericality: { only_integer: true }, length: { in: 6..8 }
  validates :user_password, presence: true
  validates :access_level, presence: true

  def normalize_name
    self.user_name = user_name.titleize
  end

  private

  def encrypt_password
    self.user_password = BCrypt::Password.create(user_password)
  end
end
