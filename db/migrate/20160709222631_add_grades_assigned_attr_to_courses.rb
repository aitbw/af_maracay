# This migration was created in order for the system to know
# if a course's students had their grades assigned after the course
# ended, so 'assign_grades' action can be only executed once
class AddGradesAssignedAttrToCourses < ActiveRecord::Migration
  def change
    change_table :courses do |t|
      t.boolean :grades_assigned, default: false
    end
  end
end
