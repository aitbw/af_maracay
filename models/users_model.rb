# Model for 'users' table
class User < ActiveRecord::Base
  # Records shown per page on 'users' view
  self.per_page = 10
  default_scope { order('user_name ASC') }

  # Relations
  has_many :payments, dependent: :destroy

  # Callbacks
  after_validation :encrypt_password, on: :create
  after_validation :normalize_name

  # Validations
  validates :user_name, presence: true
  validates :user_cedula, presence: true, uniqueness: true, numericality: { only_integer: true }, length: { in: 6..8 }
  validates :user_password, presence: true
  validates :access_level, presence: true

  # Methods
  def normalize_name
    self.user_name = user_name.titleize
  end

  def self.search_user(cedula)
    if cedula
      User.where(user_cedula: cedula)
    else
      User.all
    end
  end

  private

  def encrypt_password
    self.user_password = BCrypt::Password.create(user_password)
  end
end
