# Model for 'grades' table
class Grade < ActiveRecord::Base
  # Records shown on 'grades' view
  self.per_page = 10
  default_scope { order('date_assigned DESC') }

  # Relations
  belongs_to :student
  belongs_to :section

  # Delegations
  delegate :student_name, to: :student
  delegate :section_code, to: :section

  # Validations
  validates :final_grade, presence: true, numericality: { only_integer: true }, length: { is: 2 }
  validates :date_assigned, presence: true
end
