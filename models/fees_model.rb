require 'active_support/core_ext/date/calculations'

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
  before_validation :expiration_date, on: :create
  after_validation :fee_status, on: :create
  after_validation :credit_payment_fee
  after_validation :set_bank, on: :create
  before_save :clean_fields
  belongs_to :user
  belongs_to :student

  validates :fee_amount, presence: true, numericality: true
  validates :payment_type, presence: true
  validates :issue_date, presence: true
  validates :expiration_date, presence: true
  validates :bank, presence: true, if: :paid_with?
  validates :reference_number, presence: true, reference_number: true

  def paid_with?
    payment_type == 'Transferencia'
  end

  def expiration_date
    @student = Student.find_by(student_id: student_id)
    @course = Course.find_by(course_id: @student.course_id)

    case @course.course_type_id
    when 1..4
      self.expiration_date = Date.parse(issue_date.to_s).advance(weeks: 4)
    else
      self.expiration_date = Date.parse(issue_date.to_s).advance(weeks: 8)
    end
  rescue ArgumentError
    return
  end

  def clean_fields
    self.bank = '' if payment_type == 'Débito' || payment_type == 'Crédito'
  end

  def credit_payment_fee
    self.fee_amount += fee_amount * 0.1 if payment_type == 'Crédito'
  rescue NoMethodError
    return
  end

  def fee_status
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
