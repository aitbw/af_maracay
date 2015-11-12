class EstadoInscripciones < ActiveRecord::Migration
  def change
    add_column :inscripcionesEstudiantes, :estado_inscripcion, :string, limit: 150, null: true
  end
end
