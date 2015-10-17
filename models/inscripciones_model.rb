# Modelo para la tabla 'inscripcionesEstudiantes'
class Signup < ActiveRecord::Base
  self.table_name = 'inscripcionesEstudiantes'
  before_validation :fecha_expiracion, on: :create
  before_save :limpiar_campos
  belongs_to :estudiante
  belongs_to :usuario

  validates :costoInscripcion, presence: true, numericality: true
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
