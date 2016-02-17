class RemoveNotesFromFees < ActiveRecord::Migration
  def change
    change_table :fees do |t|
      t.remove :fee_notes
    end
  end
end
