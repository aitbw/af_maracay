# Migration for 'users' table
class CreateUsersTable < ActiveRecord::Migration
  def change
    create_table :users, primary_key: 'user_id' do |t|
      t.string :user_name, null: false, limit: 150
      t.string :user_cedula, null: false, limit: 10
      t.string :user_password, null: false
      t.string :access_level, null: false, limit: 50
      t.boolean :has_access, null: false, default: true
    end

    add_index :users, :user_cedula, unique: true
    add_index :users, :user_id, unique: true
  end
end
