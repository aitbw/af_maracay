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
  before_validation :set_expiration_date, on: :create
  after_validation :set_signup_status, on: :create
  after_validation :extra_fee_for_credit_payments
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
  validates :signup_description, presence: true, length: { maximum: 200 }
  validates :signup_notes, length: { maximum: 500 }
  delegate :student_name, :student_phone, to: :student

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

  # To deal with the signups' statuses (automatically change them if
  # the expiration date is the same as the system's or older), I created
  # an event for my database through the 'events scheduler' funcionality
  # MariaDB offers (MySQL also offers it) called 'signup_status_changer'
  # If you're working with MySQL/MariaDB, first, run the following command:
  # SET GLOBAL event_scheduler = ON;
  # Now, run the following command:
  # CREATE EVENT signup_status_changer ON SCHEDULE EVERY 1 DAY DO
  # UPDATE signups SET signup_status = 'Expired signup' WHERE
  # CURDATE() >= expiration_date;
  # If you're working with PostgreSQL, please refer to pgAdmin
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
end
