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
  include PaymentStatuses

  self.per_page = 10
  default_scope { order('issue_date DESC') }

  # Relations
  belongs_to :user
  belongs_to :student

  # Callbacks
  after_validation :update_expired_payment_status, on: :create
  after_validation :expiration_date_for_signups
  after_validation :set_payment_status, on: :create
  after_validation :extra_fee_for_credit_payments
  after_validation :bank_for_deposit_payments
  after_validation :clean_fields

  # Delegations
  delegate :student_name, :student_phone, to: :student
  delegate :user_name, to: :user

  # Validations
  validates :payment_amount, presence: true, numericality: true
  validates :payment_description, :payment_method, presence: true
  validates :bank, presence: true, if: :paid_with?
  validates :reference_number, reference_number: true

  # Custom validations
  validate :expiration_date_cant_be_blank_for_fees
  validate :issue_date_cant_be_null_for_signups_and_fees
  validate :issue_date_cant_be_in_the_past

  # Methods
  def clean_fields
    case payment_method
    when 'Débito', 'Crédito'
      self.bank = ''
    when 'Efectivo'
      self.bank = '' && self.reference_number = ''
    end
  end

  def expiration_date_cant_be_blank_for_fees
    return unless payment_description == 'Cuota' && expiration_date.blank?
    errors.add(:expiration_date, "can't be blank")
  end

  def extra_fee_for_credit_payments
    self.payment_amount += payment_amount * 0.1 if payment_method == 'Crédito'
  rescue NoMethodError
    return
  end

  def issue_date_cant_be_in_the_past
    return unless issue_date.present? && issue_date < Date.today
    errors.add(:issue_date, "can't be in the past")
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
    return unless issue_date.present? && payment_description == 'Inscripción'
    self.expiration_date = Date.parse(issue_date.to_s).next_year
  end

  def set_payment_status
    self.payment_status = 'Pago por aprobar'
  end

  # Since a student can make deposits on AF Maracay's behalf
  # on only one bank, this callback sets the payment's bank
  # automatically in order to improve the UX UI-wise.
  def bank_for_deposit_payments
    self.bank = 'BOD' if payment_method == 'Depósito'
  end

  # This callback determines which of the methods defined
  # on the PaymentStatuses module should be called when
  # creating a new Payment instance.
  def update_expired_payment_status
    case payment_description
    when 'Inscripción'
      update_expired_signup_status
    when 'Cuota'
      update_expired_fee_status
    end
  end
end
