class FeeDescriptionNotes < ActiveRecord::Migration
  def change
    change_table :fees do |t|
      t.string :fee_description, limit: 200, null: false
      t.string :fee_notes, limit: 500, null: true
    end
  end
end
