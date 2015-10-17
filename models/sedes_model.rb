# Modelo para la tabla 'sedes'
class Sede < ActiveRecord::Base
  has_many :cursos, foreign_key: 'idSede'
end
