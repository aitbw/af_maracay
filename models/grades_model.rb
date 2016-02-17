# Model for 'grades' table
class Grade < ActiveRecord::Base
  # Relations
  belongs_to :student
  belongs_to :course

  # Validations
  validates :grade, presence: true, numericality: { only_integer: true }, length: { is: 2 }
  validates :grade_date, presence: true
end
