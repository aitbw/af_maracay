class RenameCourseTypeColumns < ActiveRecord::Migration
  def change
    change_table :course_types do |t|
      t.rename :course_type, :course_name
    end
  end
end
