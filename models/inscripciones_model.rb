# Modelo para la tabla 'inscripcionesEstudiantes'
class Inscripcion < ActiveRecord::Base
  self.table_name = 'inscripcionesEstudiantes'
  before_validation :fecha_expiracion
  before_save :limpiar_campos

  validates :costoInscripcion, presence: true
  validates :tipoPago, presence: true
  validates :fechaEmision, presence: true
  validates :fechaExpiracion, presence: true
  validates :banco, presence: true, if: :pago_con?
  validates :numeroReferencia, presence: true, if: :pago_con?

  def pago_con?
    tipoPago == 'Depósito' || tipoPago == 'Transferencia'
  end

  def fecha_expiracion
    self.fechaExpiracion = Date.parse(fechaEmision.to_s).next_year
  rescue ArgumentError
    return
  end

  def limpiar_campos
    self.banco = '' && self.numeroReferencia = '' if tipoPago == 'Débito'
  end
end
