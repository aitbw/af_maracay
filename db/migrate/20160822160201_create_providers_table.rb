# Migration for 'providers' table
class CreateProvidersTable < ActiveRecord::Migration
  def change
    create_table :providers, primary_key: 'provider_id' do |t|
      t.string :provider_name, null: false, limit: 150
      t.string :provider_rif, null: false, limit: 15
      t.string :provider_phone, null: false, limit: 15
      t.string :provider_email, null: false, limit: 150
      t.string :manager_name, null: false, limit: 150
    end

    add_index :providers, :provider_id, unique: true
    add_index :providers, :provider_rif, unique: true
    add_index :providers, :provider_email, unique: true
  end
end
