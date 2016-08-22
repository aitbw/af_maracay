# Migration for 'students' table
class CreateStudentsTable < ActiveRecord::Migration
  def change
    create_table :students, primary_key: 'student_id' do |t|
      t.string :student_name, null: false, limit: 150
      t.string :student_cedula, null: false, limit: 10
      t.string :student_email, null: false, limit: 150
      t.string :student_phone, null: false, limit: 15
      t.string :alternative_phone, null: false, limit: 15
      t.boolean :has_scholarship, null: false, default: false
      t.integer :section_id, null: false
    end

    add_index :students, :student_id, unique: true
    add_index :students, :student_cedula, unique: true
    add_index :students, :student_email, unique: true
    add_foreign_key :students, :sections, primary_key: :section_id, on_update: :cascade, on_delete: :cascade
  end
end
