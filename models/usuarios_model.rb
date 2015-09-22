# Modelo para la tabla 'Usuarios'
class Usuario < ActiveRecord::Base
  validates :nombreUsuario, presence: true
  validates :cedulaUsuario, presence: true, uniqueness: true, format: { with: /\d{6,8}/ }
  validates :passwordUsuario, presence: true
end
