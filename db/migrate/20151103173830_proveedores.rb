class Proveedores < ActiveRecord::Migration
  def change
    create_table :proveedores, primary_key: 'id_proveedor' do |t|
      t.string :nombre_proveedor, limit: 150, null: false
      t.string :rif_proveedor, limit: 15, null: false
      t.string :numero_proveedor, limit: 15, null: false
      t.string :correo_proveedor, limit: 150, null: false
      t.string :direccion_proveedor, null: false
      t.string :encargado, limit: 150, null: false
    end

    add_index 'proveedores', ['rif_proveedor'], name: 'rif_proveedor_UNIQUE', unique: true, using: :btree
    add_index 'proveedores', ['correo_proveedor'], name: 'correo_proveedor_UNIQUE', unique: true, using: :btree
  end
end
