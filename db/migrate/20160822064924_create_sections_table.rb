# Migration for 'sections' table
class CreateSectionsTable < ActiveRecord::Migration
  def change
    create_table :sections, primary_key: 'section_id' do |t|
      t.integer :section_capacity, null: false
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.integer :section_hours, null: false
      t.integer :hours_covered, null: false, default: 0
      t.integer :level_id, null: false
      t.integer :course_id, null: false
    end

    add_index :sections, :section_id, unique: true
    add_foreign_key :sections, :levels, primary_key: :level_id, on_update: :cascade, on_delete: :cascade
    add_foreign_key :sections, :courses, primary_key: :course_id, on_update: :cascade, on_delete: :cascade
  end
end
