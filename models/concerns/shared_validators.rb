# Custom AR validators shared by Signup & Fee models
# encapsulated on a module in order to maximize DRYness
module SharedValidators
  # Custom validator for reference numbers
  class ReferenceNumberValidator < ActiveModel::Validator
    def validate(record)
      case record.payment_type
      when 'Débito', 'Crédito'
        unless record.reference_number =~ /\A\d{4}\z/
          record.errors[:reference_number].push('is invalid')
        end
      when 'Depósito', 'Transferencia'
        if record.reference_number.empty?
          record.errors[:reference_number].push("can't be blank")
        end
      end
    end
  end
end
