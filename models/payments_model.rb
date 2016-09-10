# Custom AR validator for payments' reference numbers
class ReferenceNumberValidator < ActiveModel::Validator
  def validate(record)
    case record.payment_method
    when 'Débito', 'Crédito'
      unless record.reference_number =~ /\A\d{4}\z/
        record.errors[:reference_number].push('is invalid')
      end
    when 'Depósito', 'Transferencia'
      if record.reference_number.empty?
        record.errors[:reference_number].push("can't be blank")
      end
    end
  end
end

# Model for 'payments' table
class Payment < ActiveRecord::Base
  include ActiveModel::Validations

  self.per_page = 10
  default_scope { order('issue_date DESC') }

  # Relations
  belongs_to :user
  belongs_to :section
  belongs_to :student

  # Callbacks
  after_validation :expiration_date_for_signups, on: :create
  after_validation :set_payment_status, on: :create
  after_validation :extra_fee_for_credit_payments
  after_validation :bank_for_deposit_payments, on: :create

  # Delegations
  delegate :student_name, :student_phone, to: :student
  delegate :user_name, to: :user

  # Validations
  validates :payment_amount, presence: true, numericality: true
  validates :payment_description, presence: true
  validates :payment_method, presence: true
  validates :bank, presence: true, if: :paid_with?
  validates :reference_number, reference_number: true

  # Custom validations
  validate :expiration_date_cant_be_null_for_fees
  validate :issue_date_cant_be_null_for_signups_and_fees
  validate :issue_date_cant_be_in_the_past

  # Methods
  def expiration_date_cant_be_null_for_fees
    if payment_description == 'Cuota' && expiration_date.blank?
      errors.add(:expiration_date, "can't be blank")
    end
  end

  def extra_fee_for_credit_payments
    self.payment_amount += payment_amount * 0.1 if payment_method == 'Crédito'
  rescue NoMethodError
    return
  end

  def issue_date_cant_be_in_the_past
    if issue_date.present? && issue_date < Date.today
      errors.add(:issue_date, "can't be in the past")
    end
  end

  def issue_date_cant_be_null_for_signups_and_fees
    case payment_description
    when 'Inscripción', 'Cuota'
      errors.add(:issue_date, "can't be blank") if issue_date.blank?
    end
  end

  def paid_with?
    payment_method == 'Transferencia'
  end

  def expiration_date_for_signups
    if issue_date.present? && payment_description == 'Inscripción'
      self.expiration_date = Date.parse(issue_date.to_s).next_year
    end
  end

  def set_payment_status
    self.payment_status = 'Pago por aprobar'
  end

  def bank_for_deposit_payments
    self.bank = 'BOD' if payment_method == 'Depósito'
  end
end
