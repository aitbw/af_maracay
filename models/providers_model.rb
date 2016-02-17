require 'active_support/core_ext/string/inflections'

# Model for 'providers' table
class Provider < ActiveRecord::Base
  VALID_EMAIL ||= /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  # Callbacks
  after_validation :normalize_provider_name
  after_validation :normalize_manager_name

  # Validations
  validates :provider_name, presence: true
  validates :provider_rif, presence: true, uniqueness: true, format: { with: /J-\d{8}-\d{1}/ }
  validates :provider_phone, presence: true, format: { with: /\d{4}-\d{7}/ }
  validates :provider_email, presence: true, uniqueness: true, format: { with: VALID_EMAIL }
  validates :manager, presence: true

  # Methods
  def normalize_provider_name
    self.provider_name = provider_name.titleize
  end

  def normalize_manager_name
    self.manager = manager.titleize
  end
end
