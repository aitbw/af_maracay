# Instance methods shared by Signup & Fee models
# encapsulated on a module in order to maximize DRYness
module SharedMethods
  def paid_with?
    payment_type == 'Transferencia'
  end

  def clean_fields
    case payment_type
    when 'Débito', 'Crédito'
      self.bank = ''
    when 'Efectivo'
      self.bank = '' && self.reference_number = ''
    end
  end

  def set_bank
    self.bank = 'BOD' if payment_type == 'Depósito'
  end
end
