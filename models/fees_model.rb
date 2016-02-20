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

  # Relations
  belongs_to :user
  belongs_to :student

  # Callbacks
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

  # To deal with the fees' statuses (automatically change them if
  # the expiration date is the same as the system's or older), I created
  # an event for my database through the 'events scheduler' funcionality
  # MariaDB offers (MySQL also offers it) called 'fee_status_changer'
  # If you're working with MySQL/MariaDB, first, run the following command:
  # SET GLOBAL event_scheduler = ON;
  # Now, run the following command:
  # CREATE EVENT fee_status_changer ON SCHEDULE EVERY 1 DAY DO
  # UPDATE fees SET fee_status = 'Expired fee' WHERE
  # CURDATE() >= expiration_date;
  # If you're working with PostgreSQL, please refer to pgAdmin
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
end
