# Modelo para la tabla 'Usuarios'
class User < ActiveRecord::Base
  self.table_name = 'usuarios'

  validates :nombreUsuario, presence: true
  validates :cedulaUsuario, presence: true, uniqueness: true, format: { with: /\d{6,8}/ }
  validates :passwordUsuario, presence: true
end
