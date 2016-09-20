/* One-option date picker */
$(function () {
  $('#datePicker').datetimepicker({
    format: 'DD/MM/YYYY'
  })
})

/* Two-option date picker */
$(function () {
  $('#leftDatePicker').datetimepicker({
    format: 'DD/MM/YYYY'
  })
  $('#rightDatePicker').datetimepicker({
    format: 'DD/MM/YYYY',
    useCurrent: false
  })
  $('#leftDatePicker').on('dp.change', function (e) {
    $('#rightDatePicker').data('DateTimePicker').minDate(e.date)
  })
  $('#rightDatePicker').on('dp.change', function (e) {
    $('#leftDatePicker').data('DateTimePicker').maxDate(e.date)
  })
})

/* Since not all payment methods require a bank to indicate where
the payment's coming from as well as not all methods generate
a reference number, this function hides the aforementioned fields
from the new Payment form in order to improve the UX */
var paymentMethod = document.getElementById('paymentMethod')

paymentMethod.onchange = function () {
  var bank = document.getElementById('bank')
  var referenceNumber = document.getElementById('referenceNumber')
  bank.style.display = (this.value !== 'Transferencia') ? 'none' : 'block'
  referenceNumber.style.display = (this.value === 'Efectivo') ? 'none' : 'block'
}
