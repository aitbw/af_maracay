# Migration for 'offices' table
class CreateOfficesTable < ActiveRecord::Migration
  def change
    create_table :offices, primary_key: 'office_id' do |t|
      t.string :office_name, null: false, limit: 50
    end

    add_index :offices, :office_id, unique: true
  end
end
