# Migration for 'course_types' table
class CreateCourseTypesTable < ActiveRecord::Migration
  def change
    create_table :course_types, primary_key: 'course_type_id' do |t|
      t.string :course_modality, null: false, limit: 50
      t.string :course_days, null: false, limit: 50
      t.string :course_schedule, null: false, limit: 50
    end

    add_index :course_types, :course_type_id, unique: true
  end
end
