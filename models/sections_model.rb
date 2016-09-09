# Model for 'sections' table
class Section < ActiveRecord::Base
  # Records shown per page on 'sections' view
  self.per_page = 10

  # Relations
  has_many :students, dependent: :destroy
  has_many :grades, dependent: :destroy
  has_many :teacher_hours, dependent: :destroy
  has_many :payments, dependent: :destroy
  belongs_to :course
  belongs_to :level

  # Delegations
  delegate :level_description, to: :level
  delegate :course_code, to: :course

  # Validations
  validates :section_capacity, presence: true, numericality: { only_integer: true }
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :section_hours, presence: true, numericality: { only_integer: true }
  validates :level_id, presence: true, uniqueness: { scope: :course_id }

  # Custom validations
  validate :start_date_cant_be_in_the_past, on: :create

  # Methods
  def start_date_cant_be_in_the_past
    if start_date.present? && start_date < Date.today
      errors.add(:start_date, "can't be in the past")
    end
  end
end
