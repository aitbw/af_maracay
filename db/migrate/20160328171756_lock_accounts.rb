class LockAccounts < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.boolean :has_access, null: false, default: true
    end
  end
end
