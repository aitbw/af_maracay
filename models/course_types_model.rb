# Model for 'course_types' table
class CourseType < ActiveRecord::Base
  has_many :courses
end
