class SignupDescriptionNotes < ActiveRecord::Migration
  def change
    change_table :signups do |t|
      t.string :signup_description, limit: 200, null: false
      t.string :signup_notes, limit: 500, null: true
    end
  end
end
