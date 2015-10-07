# Modelo para la tabla 'Usuarios'
class Usuario < ActiveRecord::Base
  before_save :cifrar_clave

  validates :nombreUsuario, presence: true
  validates :cedulaUsuario, presence: true, uniqueness: true, format: { with: /\d{6,8}/ }
  validates :passwordUsuario, presence: true

  private

  def cifrar_clave
    self.passwordUsuario = BCrypt::Password.create(passwordUsuario)
  end
end
