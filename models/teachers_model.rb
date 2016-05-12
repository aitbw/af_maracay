require 'active_support/core_ext/string/inflections'

# Model for 'teachers' table
class Teacher < ActiveRecord::Base
  VALID_EMAIL ||= /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  VALID_NUMBER ||= /04(12|14|24|16|26)-\d{7}/

  # Records shown per page on 'teachers' view
  self.per_page = 10

  # Relations
  has_many :bank_accounts, dependent: :destroy
  has_many :course_teachers
  has_many :courses, through: :course_teachers
  has_many :teacher_hours, dependent: :destroy

  # Callbacks
  after_validation :normalize_name
  before_destroy :restore_hours_to_course

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

  def self.search_teacher(cedula)
    if cedula
      Teacher.where(teacher_cedula: cedula)
    else
      Teacher.all
    end
  end
end
