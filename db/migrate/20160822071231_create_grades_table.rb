# Migration for 'grades' table
class CreateGradesTable < ActiveRecord::Migration
  def change
    create_table :grades, primary_key: 'grade_id' do |t|
      t.integer :final_grade, null: false
      t.date :date_assigned, null: false
      t.integer :student_id, null: false
      t.integer :section_id, null: false
    end

    add_index :grades, :grade_id, unique: true
    add_foreign_key :grades, :students, primary_key: :student_id, on_update: :cascade, on_delete: :cascade
    add_foreign_key :grades, :sections, primary_key: :section_id, on_update: :cascade, on_delete: :cascade
  end
end
