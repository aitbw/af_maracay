# Modelo para la tabla 'Usuarios'
class Usuario < ActiveRecord::Base
  after_validation :cifrar_clave, on: :create

  validates :nombreUsuario, presence: true
  validates :cedulaUsuario, presence: true, uniqueness: true, format: { with: /\d{6,8}/ }
  validates :passwordUsuario, presence: true
  validates :nivelAcceso, presence: true

  private

  def cifrar_clave
    self.passwordUsuario = BCrypt::Password.create(passwordUsuario)
  end
end
