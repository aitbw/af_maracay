# Model for 'students' table
class Student < ActiveRecord::Base
  VALID_EMAIL ||= /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  VALID_NUMBER ||= /\A\d{4}-\d{7}\z/

  # Records shown per page on 'students' view
  self.per_page = 10
  default_scope { order('student_name ASC') }

  # Relations
  belongs_to :section
  has_many :payments, dependent: :destroy
  has_many :grades, dependent: :destroy

  # Callbacks
  after_validation :normalize_name
  after_validation :add_student_to_section
  before_destroy :remove_student_from_section

  # Validations
  validates :student_name, presence: true
  validates :student_cedula, presence: true, uniqueness: true, numericality: { only_integer: true }, length: { in: 6..8 }
  validates :student_email, presence: true, uniqueness: true, format: { with: VALID_EMAIL }
  validates :student_phone, presence: true, format: { with: VALID_NUMBER }
  validates :alternative_phone, presence: true, format: { with: VALID_NUMBER }
  validates :section_id, presence: true

  # Methods
  def normalize_name
    self.student_name = student_name.titleize
  end

  def self.search_student(cedula)
    if cedula
      Student.where(student_cedula: cedula)
    else
      Student.all
    end
  end

  def add_student_to_section
    begin
      section = Section.find(section_id)
    rescue ActiveRecord::RecordNotFound
      return
    end

    section.section_capacity -= 1
    section.save!
  end

  def remove_student_from_section
    begin
      section = Section.find(section_id)
    rescue ActiveRecord::RecordNotFound
      return
    end

    section.section_capacity += 1
    section.save!
  end
end
