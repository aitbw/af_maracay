# Model for 'grades' table
class Grade < ActiveRecord::Base
  # Records shown on 'grades' view
  self.per_page = 10
  default_scope { order('grade_date DESC') }

  # Relations
  belongs_to :student
  belongs_to :course

  # Delegations
  delegate :course_code, :course_level, to: :course
  delegate :student_name, to: :student

  # Validations
  validates :grade, presence: true, numericality: { only_integer: true }, length: { is: 2 }
  validates :grade_date, presence: true
end
