# Migration for 'levels' table
class CreateLevelsTable < ActiveRecord::Migration
  def change
    create_table :levels, primary_key: 'level_id' do |t|
      t.string :level_description, null: false, limit: 50
    end

    add_index :levels, :level_id, unique: true
  end
end
