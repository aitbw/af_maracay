# Model for 'bank_accounts' table
class BankAccount < ActiveRecord::Base
  # Relations
  belongs_to :teacher
  belongs_to :bank

  # Delegations
  delegate :bank_name, to: :bank
  delegate :teacher_name, to: :teacher

  # Validations
  validates :bank_id, presence: true
  validates :account_number, presence: true, numericality: { only_integer: true }, length: { is: 20 }, uniqueness: { scope: :bank_id }
  validates :account_type, presence: true
end
