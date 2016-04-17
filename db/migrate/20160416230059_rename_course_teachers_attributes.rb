# This migration was created to rename the 'course_teachers' table
# attributes since MySQL Workbench pretty much screwed the way
# many-to-many table attributes should be named, and so
# the CourseTeacher association wasn't working as expected.
# With this migration, it now works properly, and you can either
# call @teacher.courses OR @course.teachers and if the course has
# teachers assigned OR a teacher has courses assigned, they will
# be properly selected and shown on your view.
class RenameCourseTeachersAttributes < ActiveRecord::Migration
  def up
    remove_foreign_key :course_teachers, column: :courses_course_id
    remove_foreign_key :course_teachers, column: :teachers_teacher_id
    rename_column :course_teachers, :courses_course_id, :course_id
    rename_column :course_teachers, :teachers_teacher_id, :teacher_id
    add_foreign_key :course_teachers, :courses, primary_key: :course_id, on_delete: :cascade, on_update: :cascade
    add_foreign_key :course_teachers, :teachers, primary_key: :teacher_id, on_delete: :cascade, on_update: :cascade
  end
end
