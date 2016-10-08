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

  # Callbacks
  after_validation :generate_section_code

  # Delegations
  delegate :level_description, to: :level
  delegate :course_code, to: :course

  # Validations
  validates :section_capacity, :section_hours, presence: true, numericality: { only_integer: true }
  validates :start_date, :end_date, presence: true
  validates :level_id, presence: true, uniqueness: { scope: :course_id }

  # Custom validations
  validate :start_date_cant_be_in_the_past, on: :create

  # Methods
  def start_date_cant_be_in_the_past
    return unless start_date.present? && start_date < Date.today
    errors.add(:start_date, "can't be in the past")
  end

  def generate_section_code
    self.section_code = "#{course_code} - #{level_description}"
  end
end
