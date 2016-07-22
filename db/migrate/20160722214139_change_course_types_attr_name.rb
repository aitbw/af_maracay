class ChangeCourseTypesAttrName < ActiveRecord::Migration
  def up
    change_table :course_types do |t|
      t.rename :course_name, :course_modality
    end
  end

  def down
    change_table :course_types do |t|
      t.rename :course_modality, :course_name
    end
  end
end
