require 'active_support/core_ext/string/inflections'

# Model for 'students' table
class Student < ActiveRecord::Base
  VALID_EMAIL ||= /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  VALID_NUMBER ||= /\A04(12|14|24|16|26)-\d{7}\z/

  # Records shown per page on 'students' view
  self.per_page = 10

  # Relations
  belongs_to :course
  has_many :signups, dependent: :destroy
  has_many :fees, dependent: :destroy
  has_many :grades, dependent: :destroy

  # Callbacks
  after_validation :normalize_name

  # Delegations
  delegate :course_code, to: :course

  # Validations
  validates :course_id, presence: true
  validates :student_name, presence: true
  validates :student_email, presence: true, uniqueness: true, format: { with: VALID_EMAIL }
  validates :student_phone, presence: true, format: { with: VALID_NUMBER }
  validates :student_cedula, presence: true, uniqueness: true, numericality: { only_integer: true }, length: { in: 6..8 }

  # Methods
  def normalize_name
    self.student_name = student_name.titleize
  end

  def self.search_student(cedula)
    if cedula
      Student.where(student_cedula: cedula)
    else
      Student.all
    end
  end
end
