class CreateBanksTable < ActiveRecord::Migration
  def change
    create_table :banks, primary_key: 'bank_id' do |t|
      t.string :bank_name, null: false, limit: 50
    end

    add_index :banks, :bank_id, unique: true
  end
end
