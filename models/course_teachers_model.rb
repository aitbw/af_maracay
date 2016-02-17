# Model for 'course_teachers' table
class CourseTeacher < ActiveRecord::Base
  # Relations
  belongs_to :teacher
  belongs_to :course
end
