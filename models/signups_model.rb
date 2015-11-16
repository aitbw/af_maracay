# Custom validator for reference numbers
class ReferenceNumberValidator < ActiveModel::Validator
  def validate(record)
    case record.payment_type
    when 'Débito', 'Crédito'
      unless /\d{4}/.match(record.reference_number)
        record.errors[:reference_number].push('is invalid')
      end
    when 'Depósito', 'Transferencia'
      if record.reference_number.empty?
        record.errors[:reference_number].push("can\'t be blank")
      end
    end
  end
end

# Model for 'signups' table
class Signup < ActiveRecord::Base
  include ActiveModel::Validations
  before_validation :expiration_date, on: :create
  after_validation :signup_status, on: :create
  after_validation :credit_payment_fee
  after_validation :set_bank, on: :create
  before_save :clean_fields
  belongs_to :student
  belongs_to :user

  validates :signup_amount, presence: true, numericality: true
  validates :payment_type, presence: true
  validates :issue_date, presence: true
  validates :expiration_date, presence: true
  validates :bank, presence: true, if: :paid_with?
  validates :reference_number, reference_number: true

  def paid_with?
    payment_type == 'Transferencia'
  end

  def expiration_date
    self.expiration_date = Date.parse(issue_date.to_s).next_year
  rescue ArgumentError
    return
  end

  def clean_fields
    case payment_type
    when 'Débito', 'Crédito'
      self.bank = ''
    when 'Efectivo'
      self.bank = '' && self.reference_number = ''
    end
  end

  def credit_payment_fee
    self.signup_amount += signup_amount * 0.1 if payment_type == 'Crédito'
  rescue NoMethodError
    return
  end

  def signup_status
    case payment_type
    when 'Depósito', 'Transferencia'
      self.signup_status = 'Inscripción por aprobar'
    else
      self.signup_status = 'Inscripción vigente'
    end
  end

  def set_bank
    self.bank = 'BOD' if payment_type == 'Depósito'
  end
end
