# Custom validator for reference numbers
class ReferenceNumberValidator < ActiveModel::Validator
  def validate(record)
    case record.payment_type
    when 'Débito', 'Crédito'
      unless /\d{4}/.match(record.reference_number)
        record.errors[:reference_number].push('is invalid')
      end
    end
  end
end

# Model for 'fees' table
class Fee < ActiveRecord::Base
  include ActiveModel::Validations

  # Records shown on 'fees' view
  self.per_page = 10

  # Relations
  belongs_to :user
  belongs_to :student

  # Callbacks
  after_validation :set_latest_fee_status, on: :create
  after_validation :set_fee_status, on: :create
  after_validation :extra_fee_for_credit_payments
  after_validation :set_bank, on: :create
  before_save :clean_fields

  # Delegations
  delegate :student_name, :student_phone, to: :student
  delegate :user_name, to: :user

  # Validations
  validates :fee_amount, presence: true, numericality: true
  validates :payment_type, presence: true
  validates :issue_date, presence: true
  validates :expiration_date, presence: true
  validates :bank, presence: true, if: :paid_with?
  validates :reference_number, presence: true, reference_number: true
  validates :fee_description, presence: true, length: { maximum: 200 }

  # Methods
  def paid_with?
    payment_type == 'Transferencia'
  end

  def clean_fields
    self.bank = '' if payment_type == 'Débito' || payment_type == 'Crédito'
  end

  def extra_fee_for_credit_payments
    self.fee_amount += fee_amount * 0.1 if payment_type == 'Crédito'
  rescue NoMethodError
    return
  end

  # Since 'Deposit' and 'Transfer' payments need to be confirmed
  # beforehand by an Alliance Francaise admin, the Fee model
  # sets a status to that kind of payments thanks to this callback.
  def set_fee_status
    case payment_type
    when 'Depósito', 'Transferencia'
      self.fee_status = 'Cuota por aprobar'
    else
      self.fee_status = 'Cuota vigente'
    end
  end

  def set_bank
    self.bank = 'BOD' if payment_type == 'Depósito'
  end

  def set_latest_fee_status
    unless Fee.where(student_id: student_id).empty?
      @latest_fee = Fee.where(student_id: student_id).last
      @latest_fee.update(is_latest_fee: false)
    end
  end
end
