# Modelo para la tabla 'cuentasBanco'
class Account < ActiveRecord::Base
  self.table_name = 'cuentasBanco'
  belongs_to :teacher
  belongs_to :banco

  validates :idBanco, presence: true
  validates :numeroCuenta, presence: true, format: { with: /\d{20}/ }, uniqueness: { scope: :idBanco }
  validates :tipoCuenta, presence: true
end
