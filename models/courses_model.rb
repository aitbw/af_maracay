# Model for 'course_types' table
class CourseType < ActiveRecord::Base
  has_many :courses
end

# Model for 'courses' table
class Course < ActiveRecord::Base
  COURSE_CODE ||= /[ABC](1|2)[A-Z]{2}\d{2}/
  COURSE_LEVEL ||= /[ABC](1|2)-(?:[01][0-9]|1[0-5])/
  has_many :students, dependent: :destroy
  belongs_to :course_types
  belongs_to :office

  validates :course_type_id, presence: true
  validates :office_id, presence: true
  validates :course_code, presence: true, uniqueness: true, format: { with: COURSE_CODE }
  validates :course_level, presence: true, format: { with: COURSE_LEVEL }
  validates :course_capacity, presence: true, numericality: { only_integer: true }, length: { is: 2 }
  validates :start_date, presence: true
  validates :completion_date, presence: true
  validates :course_hours, presence: true, numericality: { only_integer: true }
end
