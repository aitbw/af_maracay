class RemoveNotesFromSignups < ActiveRecord::Migration
  def change
    change_table :signups do |t|
      t.remove :signup_notes
    end
  end
end
