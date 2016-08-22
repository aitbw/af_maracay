class CreateCourseTeachersTable < ActiveRecord::Migration
  def change
    create_join_table :courses, :teachers, table_name: 'course_teachers' do |t|
      t.index :course_id
      t.index :teacher_id
    end

    add_foreign_key :course_teachers, :courses, primary_key: :course_id, on_update: :cascade, on_delete: :cascade
    add_foreign_key :course_teachers, :teachers, primary_key: :teacher_id, on_update: :cascade, on_delete: :cascade
  end
end
