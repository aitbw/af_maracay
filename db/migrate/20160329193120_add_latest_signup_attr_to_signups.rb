class AddLatestSignupAttrToSignups < ActiveRecord::Migration
  def up
    change_table :signups do |t|
      t.boolean :is_latest_signup, null: false, default: true
    end
  end

  def down
    remove_column :signups, :is_latest_signup, :boolean
  end
end
