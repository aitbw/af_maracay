class AddAltPhoneToStudents < ActiveRecord::Migration
  def up
    change_table :students do |t|
      t.string :alt_phone, null: false, limit: 15
    end
  end

  def down
    remove_column :students, :alt_phone, :string
  end
end
