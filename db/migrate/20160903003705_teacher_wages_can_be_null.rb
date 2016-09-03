class TeacherWagesCanBeNull < ActiveRecord::Migration
  def change
    change_column_null :teachers, :teacher_wages, true
  end
end
