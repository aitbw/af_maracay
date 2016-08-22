# Migration for 'courses' table
class CreateCoursesTable < ActiveRecord::Migration
  def change
    create_table :courses, primary_key: 'course_id' do |t|
      t.string :course_code, null: false, limit: 50
      t.integer :course_type_id, null: false
      t.integer :office_id, null: false
    end

    add_index :courses, :course_id, unique: true
    add_index :courses, :course_code, unique: true
    add_foreign_key :courses, :course_types, primary_key: :course_type_id, on_update: :cascade, on_delete: :cascade
    add_foreign_key :courses, :offices, primary_key: :office_id, on_update: :cascade, on_delete: :cascade
  end
end
