class AddFksConstraintsToMovements < ActiveRecord::Migration
  def change
    change_table :movements do |t|
      t.integer :office_id, null: false
      t.integer :item_id, null: false
    end

    add_foreign_key :movements, :items, primary_key: :item_id, on_update: :cascade, on_delete: :cascade
    add_foreign_key :movements, :offices, primary_key: :office_id, on_update: :cascade, on_delete: :cascade
  end
end
