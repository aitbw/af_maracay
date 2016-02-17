# Model for 'course_types' table
class CourseType < ActiveRecord::Base
  # Relations
  has_many :courses
end
