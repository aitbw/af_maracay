class AddFksConstraintsToOfficeItems < ActiveRecord::Migration
  def change
    add_foreign_key :office_items, :offices, primary_key: :office_id, on_update: :cascade, on_delete: :cascade
    add_foreign_key :office_items, :items, primary_key: :item_id, on_update: :cascade, on_delete: :cascade
  end
end
