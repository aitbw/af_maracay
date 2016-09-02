# Model for the 'teacher_hours' model
class TeacherHour < ActiveRecord::Base
  # Records shown on 'teacher_hours' view
  self.per_page = 10
  default_scope { order('date_covered DESC') }

  # Relations
  belongs_to :section
  belongs_to :teacher

  # Callbacks
  after_validation :discount_hours_from_section, on: :create
  before_destroy :restore_hours_to_section

  # Delegations
  delegate :teacher_name, to: :teacher

  # Validations
  validates :hours_covered, presence: true, numericality: { only_integer: true }
  validates :date_covered, presence: true
  validates :fare_per_hour, presence: true

  # Custom validations
  validate :valid_date?

  # Methods

  # Since the hours assigned to a teacher must be discounted from the section
  # he/she's in charge with, this callback discounts those hours from the total
  # hours the section was set to have when it was created and moves them to the
  # 'hours_covered' column.
  def discount_hours_from_section
    begin
      section = Section.find(section_id)
      section.section_hours -= hours_covered
      section.hours_covered += hours_covered
    rescue ActiveRecord::RecordNotFound, TypeError
      return
    end
    section.save!
  end

  # This validation ensures the date entered on the form is between the
  # section's start and end date range.
  def valid_date?
    begin
      section = Section.find(section_id)
    rescue ActiveRecord::RecordNotFound
      return
    end

    date_range = (section.start_date.to_s)..(section.completion_date.to_s)

    unless date_range.cover?(date_covered.to_s)
      errors.add(:date_covered, "must be between the range of the section's start and end date")
    end
  end

  # If an user happens to assign hours to a teacher by mistake, the record
  # can be easily destroyed and restore the discounted hours to the section
  # thanks to this callback
  def restore_hours_to_section
    section = Section.find(section_id)

    section.section_hours += hours_covered
    section.hours_covered -= hours_covered
    section.save!
  end
end
