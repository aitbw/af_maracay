# Model for 'users' table
class User < ActiveRecord::Base
  after_validation :encrypt_password, on: :create
  has_many :signups, dependent: :destroy
  has_many :fees, dependent: :destroy

  validates :user_name, presence: true
  validates :user_cedula, presence: true, uniqueness: true, format: { with: /\d{6,8}/ }
  validates :user_password, presence: true
  validates :access_level, presence: true

  private

  def encrypt_password
    self.user_password = BCrypt::Password.create(user_password)
  end
end
