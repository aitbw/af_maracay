# Migration for 'items' table
class CreateItemsTable < ActiveRecord::Migration
  def change
    create_table :items, primary_key: 'item_id' do |t|
      t.string :item_name, null: false, limit: 100
      t.string :item_type, null: false, limit: 50
      t.float :item_price, null: false
    end

    add_index :items, :item_id, unique: true
  end
end
