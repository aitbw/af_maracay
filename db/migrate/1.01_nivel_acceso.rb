class NivelAcceso < ActiveRecord::Migration
  def change
    change_table :usuarios do |t|
      t.change :nivelAcceso, :string, null: false
    end
  end
end
