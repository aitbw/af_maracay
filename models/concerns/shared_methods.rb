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

  def issue_date_cant_be_in_the_past
    if issue_date.present? && issue_date < Date.today
      errors.add(:issue_date, "can't be in the past")
    end
  end
end
