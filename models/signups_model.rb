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

  # Records shown on 'signups' view
  self.per_page = 10

  # Relations
  belongs_to :student
  belongs_to :user

  # Callbacks
  after_validation :set_expiration_date, on: :create
  after_validation :set_latest_signup_status, on: :create
  after_validation :set_signup_status, on: :create
  after_validation :extra_fee_for_credit_payments
  after_validation :set_bank, on: :create
  before_save :clean_fields

  # Delegations
  delegate :student_name, :student_phone, to: :student
  delegate :user_name, to: :user

  # Validations
  validates :signup_amount, presence: true, numericality: true
  validates :payment_type, presence: true
  validates :issue_date, presence: true
  validates :bank, presence: true, if: :paid_with?
  validates :reference_number, reference_number: true
  validates :signup_description, presence: true, length: { maximum: 200 }

  # Methods
  def paid_with?
    payment_type == 'Transferencia'
  end

  def set_expiration_date
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

  def extra_fee_for_credit_payments
    self.signup_amount += signup_amount * 0.1 if payment_type == 'Crédito'
  rescue NoMethodError
    return
  end

  # Since 'Deposit' and 'Transfer' payments need to be confirmed
  # beforehand by an Alliance Francaise admin, the Signup model
  # sets a status to that kind of payments thanks to this callback.
  def set_signup_status
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

  def set_latest_signup_status
    unless Signup.where(student_id: student_id).empty?
      @latest_signup = Signup.where(student_id: student_id).last
      @latest_signup.update(is_latest_signup: false)
    end
  end
end
