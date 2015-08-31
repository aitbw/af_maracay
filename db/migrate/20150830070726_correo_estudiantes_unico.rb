class CorreoEstudiantesUnico < ActiveRecord::Migration
  def change
    add_index :estudiantes, :correoEstudiante, unique: true
  end
end
