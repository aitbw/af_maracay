# Migration for 'office_items' table
class CreateOfficeItemsTable < ActiveRecord::Migration
  def change
    create_join_table :offices, :items, table_name: 'office_items' do |t|
      t.index :office_id
      t.index :item_id
      t.integer :item_amount, null: false
    end
  end
end
