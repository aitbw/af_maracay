# This migration was created in order for the system to know
# if a course has finished, so the 'promote course' action can
# only be executed once
class AddIsFinishedAttrToCourses < ActiveRecord::Migration
  def change
    change_table :courses do |t|
      t.boolean :is_finished, default: false
    end
  end
end
