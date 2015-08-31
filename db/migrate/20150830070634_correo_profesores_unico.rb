class CorreoProfesoresUnico < ActiveRecord::Migration
  def change
    add_index :profesores, :correoProfesor, unique: true
  end
end
