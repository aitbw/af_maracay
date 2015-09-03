# Modelo para la tabla 'cuentasBanco'
class Account < ActiveRecord::Base
  self.table_name = 'cuentasBanco'

  validates :numeroCuenta, presence: true, format: { with: /\d{20}/ }
  validates :tipoCuenta, presence: true
end
