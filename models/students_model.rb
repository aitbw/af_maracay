# Modelo para la tabla 'estudiantes'
class Estudiante < ActiveRecord::Base
  VALID_EMAIL_REGEX ||= /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  validates :nombreEstudiante, presence: true
  validates :correoEstudiante, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
  validates :telefonoEstudiante, presence: true, format: { with: /\d{4}-?\d{7}/ }
  validates :cedulaEstudiante, presence: true, uniqueness: true, format: { with: /\d{6,8}/ }
end
