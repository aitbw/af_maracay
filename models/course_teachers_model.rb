# Model for 'course_teachers' table
class CourseTeacher < ActiveRecord::Base
  belongs_to :teacher
  belongs_to :course
end
