# Model for 'courses' table
class Course < ActiveRecord::Base
  COURSE_CODE ||= /\A\d{4}-\w{4}\d{1}-\d{3}\z/

  # Records shown per page on 'courses' view
  self.per_page = 10

  # Relations
  has_many :course_teachers
  has_many :teachers, through: :course_teachers
  has_many :sections, dependent: :destroy
  belongs_to :course_type
  belongs_to :office

  # Delegations
  delegate :course_modality, to: :course_type
  delegate :office_name, to: :office

  # Validations
  validates :course_code, presence: true, uniqueness: true, format: { with: COURSE_CODE }
  validates :course_type_id, presence: true
  validates :office_id, presence: true

  # Methods
  def self.search_course(code)
    if code
      Course.where(course_code: code)
    else
      Course.all
    end
  end
end
