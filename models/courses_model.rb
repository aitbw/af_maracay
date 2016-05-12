# Model for 'courses' table
class Course < ActiveRecord::Base
  COURSE_CODE ||= /\d{4}-\w{4}\d{1}-\d{3}/
  COURSE_LEVEL ||= /[ABC](?:1|2)-(?:0[1-9]|1[0-5])/

  # Records shown per page on 'courses' view
  self.per_page = 10

  # Relations
  has_many :students, dependent: :destroy
  has_many :grades, dependent: :destroy
  has_many :course_teachers
  has_many :teachers, through: :course_teachers
  has_many :teacher_hours, dependent: :destroy
  belongs_to :course_type
  belongs_to :office

  # Delegations
  delegate :office_name, to: :office
  delegate :course_name, to: :course_type

  # Validations
  validates :course_type_id, presence: true
  validates :office_id, presence: true
  validates :course_code, presence: true, uniqueness: true, format: { with: COURSE_CODE }
  validates :course_level, presence: true, format: { with: COURSE_LEVEL }
  validates :course_capacity, presence: true, numericality: { only_integer: true }, length: { is: 2 }
  validates :start_date, presence: true
  validates :completion_date, presence: true
  validates :course_hours, presence: true, numericality: { only_integer: true }

  # Methods
  def self.search_course(code)
    if code
      Course.where(course_code: code)
    else
      Course.all
    end
  end
end
