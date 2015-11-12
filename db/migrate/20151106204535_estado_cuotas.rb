class EstadoCuotas < ActiveRecord::Migration
  def change
    add_column :cuotasEstudiantes, :estado_cuota, :string, limit: 150, null: true
  end
end
