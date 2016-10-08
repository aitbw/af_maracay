# For Signup and Fee payments, there can be only one active per
# description at a time, so every time a new Signup or Fee is
# created, this module's methods check if the student has
# signups or fees on his/her name. If the student does have any
# of these aforementioned records to his/her name, the method
# retrieves the last related signup or fee and updates its status,
# rendering it expired.

# This module's methods are tied to the Payment model callback
# named :update_expired_payment_status, which gets called only
# when creating a new Payment instance.
module PaymentStatuses
  def update_expired_signup_status
    return if Payment.where('payment_description = ? AND student_id = ?', 'Inscripción', student_id).empty?
    @latest_signup = Payment.where('payment_description = ? AND student_id = ?', 'Inscripción', student_id).last
    @latest_signup.update(payment_status: 'Inscripción vencida')
  end

  def update_expired_fee_status
    return if Payment.where('payment_description = ? AND student_id = ?', 'Cuota', student_id).empty?
    @latest_signup = Payment.where('payment_description = ? AND student_id = ?', 'Cuota', student_id).last
    @latest_signup.update(payment_status: 'Cuota vencida')
  end
end
