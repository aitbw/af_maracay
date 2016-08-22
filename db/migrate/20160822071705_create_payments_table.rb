# Migration for 'payments' table
class CreatePaymentsTable < ActiveRecord::Migration
  def change
    create_table :payments, primary_key: 'payment_id' do |t|
      t.float :payment_amount, null: false
      t.string :payment_description, null: false, limit: 50
      t.string :payment_method, null: false, limit: 50
      t.string :payment_status, null: false, limit: 50
      t.date :issue_date, null: false
      t.date :expiration_date, null: false
      t.string :bank, null: true, limit: 50
      t.string :reference_number, null: true, limit: 50
      t.integer :user_id, null: false
      t.integer :student_id, null: false
      t.integer :section_id, null: false
    end

    add_index :payments, :payment_id, unique: true
    add_foreign_key :payments, :users, primary_key: :user_id, on_update: :cascade, on_delete: :cascade
    add_foreign_key :payments, :students, primary_key: :student_id, on_update: :cascade, on_delete: :cascade
    add_foreign_key :payments, :sections, primary_key: :section_id, on_update: :cascade, on_delete: :cascade
  end
end
