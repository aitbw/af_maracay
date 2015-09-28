# Modelo para la tabla 'tiposCursos'
class Tipo < ActiveRecord::Base
  self.table_name = 'tiposCurso'
end

# Modelo para la tabla Cursos
class Curso < ActiveRecord::Base
  COURSE_CODE ||= /[ABC](1|2) [A-Z]{2} \d{2}/

  validates :codigoCurso, presence: true, uniqueness: true, format: { with: COURSE_CODE }
  validates :nivelCurso, presence: true, format: { with: /[ABC](1|2)-[1-5]{1}/ }
  validates :capacidadCurso, presence: true, format: { with: /\d{2}/ }
  validates :inicioCurso, presence: true
  validates :finCurso, presence: true
  validates :horasCurso, presence: true, format: { with: /\d/ }
end
