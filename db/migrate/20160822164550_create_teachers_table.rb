class CreateTeachersTable < ActiveRecord::Migration
  def change
    enable_extension 'hstore' unless extension_enabled?('hstore')
    create_table :teachers, primary_key: 'teacher_id' do |t|
      t.string :teacher_name, null: false, limit: 150
      t.string :teacher_email, null: false, limit: 150
      t.string :teacher_phone, null: false, limit: 15
      t.string :teacher_cedula, null: false, limit: 10
      t.hstore :teacher_wages, null: false
      t.date :entry_date, null: false
    end

    add_index :teachers, :teacher_id, unique: true
    add_index :teachers, :teacher_email, unique: true
    add_index :teachers, :teacher_cedula, unique: true
  end
end
