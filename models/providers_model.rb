require 'active_support/core_ext/string/inflections'

# Model for 'providers' table
class Provider < ActiveRecord::Base
  VALID_EMAIL ||= /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  VALID_NUMBER ||= /\A04(12|14|24|16|26)-\d{7}\z/
  VALID_RIF ||= /\AJ-\d{8}-\d{1}\z/

  # Records show per page on 'providers' view
  self.per_page = 10

  # Callbacks
  after_validation :normalize_provider_name
  after_validation :normalize_manager_name

  # Validations
  validates :provider_name, presence: true
  validates :provider_rif, presence: true, uniqueness: true, format: { with: VALID_RIF }
  validates :provider_phone, presence: true, format: { with: VALID_NUMBER }
  validates :provider_email, presence: true, uniqueness: true, format: { with: VALID_EMAIL }
  validates :manager, presence: true

  # Methods
  def normalize_provider_name
    self.provider_name = provider_name.titleize
  end

  def normalize_manager_name
    self.manager = manager.titleize
  end

  def self.search_provider(name)
    if name
      Provider.where('provider_name LIKE ?', "%#{name}%")
    else
      Provider.all
    end
  end
end
