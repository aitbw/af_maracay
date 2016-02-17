# Model for 'banks' table
class Bank < ActiveRecord::Base
  # Relations
  has_many :bank_accounts
end
