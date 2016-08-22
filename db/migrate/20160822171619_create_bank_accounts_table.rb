class CreateBankAccountsTable < ActiveRecord::Migration
  def change
    create_table :bank_accounts, primary_key: 'bank_account_id' do |t|
      t.string :account_number, null: false, limit: 50
      t.string :account_type, null: false, limit: 50
      t.integer :teacher_id, null: false
      t.integer :bank_id, null: false
    end

    add_index :bank_accounts, :bank_account_id, unique: true
    add_foreign_key :bank_accounts, :teachers, primary_key: :teacher_id, on_update: :cascade, on_delete: :cascade
    add_foreign_key :bank_accounts, :banks, primary_key: :bank_id, on_update: :cascade, on_delete: :cascade
  end
end
