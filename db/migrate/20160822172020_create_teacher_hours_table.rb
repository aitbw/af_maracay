class CreateTeacherHoursTable < ActiveRecord::Migration
  def change
    create_table :teacher_hours, primary_key: 'teacher_hour_id' do |t|
      t.integer :hours_covered, null: false
      t.date :date_covered, null: false
      t.boolean :teacher_substituted, null: false, default: false
      t.integer :teacher_id, null: false
      t.integer :section_id, null: false
    end

    add_index :teacher_hours, :teacher_hour_id, unique: true
    add_foreign_key :teacher_hours, :teachers, primary_key: :teacher_id, on_update: :cascade, on_delete: :cascade
    add_foreign_key :teacher_hours, :sections, primary_key: :section_id, on_update: :cascade, on_delete: :cascade
  end
end
