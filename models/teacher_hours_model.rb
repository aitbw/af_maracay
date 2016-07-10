# Model for the 'teacher_hours' model
class TeacherHour < ActiveRecord::Base
  # Records shown on 'teacher_hours' view
  # self.per_page = 10

  # Relations
  belongs_to :teacher
  belongs_to :course

  # Callbacks
  before_validation :valid_date?
  after_validation :discount_hours_from_course, on: :create
  before_destroy :restore_hours_to_course

  # Delegations
  delegate :course_code, to: :course
  delegate :teacher_name, to: :teacher

  # Validations
  validates :hours_covered, presence: true, numericality: { only_integer: true }, length: { is: 1 }
  validates :date_covered, presence: true
  validates :course_id, presence: true

  # Methods

  # Since the hours assigned to a teacher must be discounted from the course
  # he/she's in charge with, this callback discounts those hours from the total
  # hours the course was set to have when it was created and moves them to the
  # 'hours_covered' column.
  def discount_hours_from_course
    course = Course.find(course_id)

    course.course_hours -= hours_covered
    course.hours_covered += hours_covered
    course.save!
  end

  # This callback ensures the date entered on the form is between the course's
  # start and completion date range.
  def valid_date?
    course = Course.find(course_id)
    date_range = (course.start_date.to_s)..(course.completion_date.to_s)

    unless date_range.cover?(date_covered.to_s)
      errors.add(:date_covered, "must be between the range of the course's start and end date")
    end
  end

  # If an user happens to assign hours to a teacher by mistake, the record
  # can be easily destroyed and restore the discounted hours to the course
  # thanks to this callback
  def restore_hours_to_course
    course = Course.find(course_id)

    course.course_hours += hours_covered
    course.hours_covered -= hours_covered
    course.save!
  end
end
