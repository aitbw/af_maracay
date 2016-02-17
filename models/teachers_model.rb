require 'active_support/core_ext/string/inflections'

# Model for 'teachers' table
class Teacher < ActiveRecord::Base
  VALID_EMAIL ||= /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  VALID_NUMBER ||= /04(12|14|24|16|26)-\d{7}/

  # Relations
  has_many :bank_accounts, dependent: :destroy
  has_many :course_teachers
  has_many :courses, through: :course_teachers

  # Callbacks
  after_validation :normalize_name

  # Validations
  validates :teacher_name, presence: true
  validates :teacher_phone, presence: true, format: { with: VALID_NUMBER }
  validates :teacher_email, presence: true, uniqueness: true, format: { with: VALID_EMAIL }
  validates :teacher_cedula, presence: true, uniqueness: true, numericality: { only_integer: true }, length: { in: 6..8 }
  validates :teacher_wage, presence: true, numericality: true
  validates :entry_date, presence: true

  # Methods
  def normalize_name
    self.teacher_name = teacher_name.titleize
  end
end
