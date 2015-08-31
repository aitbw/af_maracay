# Modelo para la tabla 'Profesores'
class Teacher < ActiveRecord::Base
  self.table_name = 'profesores'
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  validates :nombreProfesor, presence: true
  validates :telefonoProfesor, presence: true, format: { with: /\d{4}-?\d{7}/ }
  validates :correoProfesor, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
  validates :cedulaProfesor, presence: true, uniqueness: true, format: { with: /\d{6,8}/ }
end
