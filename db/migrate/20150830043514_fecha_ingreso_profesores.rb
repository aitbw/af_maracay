class FechaIngresoProfesores < ActiveRecord::Migration
  def change
    add_column :profesores, :fechaIngreso, :date, null: false
  end
end
