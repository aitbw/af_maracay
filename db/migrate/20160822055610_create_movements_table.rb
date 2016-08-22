# Migration for 'movements' table
class CreateMovementsTable < ActiveRecord::Migration
  def change
    create_table :movements, primary_key: 'movement_id' do |t|
      t.string :movement_type, null: false, limit: 50
      t.integer :movement_amount, null: false
      t.date :movement_date, null: false
    end

    add_index :movements, :movement_id, unique: true
  end
end
