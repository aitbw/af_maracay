# Modelo para la tabla 'tiposCursos'
class Type < ActiveRecord::Base
  self.table_name = 'tiposCursos'
end

# Modelo para la tabla Cursos
class Course < ActiveRecord::Base
  self.table_name = 'cursos'

  validates :capacidadCurso, presence: true, format: { with: /\d{2}/ }
  validates :inicioCurso, presence: true
  validates :finCurso, presence: true
  validates :horasCurso, presence: true, format: { with: /\d/ }
end
