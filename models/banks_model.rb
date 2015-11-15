# Model for 'banks' table
class Bank < ActiveRecord::Base
  has_many :bank_accounts
end
