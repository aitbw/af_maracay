class AddLatestFeeAttrToFees < ActiveRecord::Migration
  def up
    change_table :fees do |t|
      t.boolean :is_latest_fee, null: false, default: true
    end
  end

  def down
    remove_column :fees, :is_latest_fee, :boolean
  end
end
