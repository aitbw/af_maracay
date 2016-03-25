/* One-option date picker */
$(function () {
  $('#datePicker').datetimepicker({
    format: 'DD/MM/YYYY'
  });
});

/* Two-option date picker */
$(function () {
  $('#leftDatePicker').datetimepicker({
    format: 'DD/MM/YYYY'
  });
  $('#rightDatePicker').datetimepicker({
    format: 'DD/MM/YYYY',
    useCurrent: false
  });
  $('#leftDatePicker').on('dp.change', function (e) {
    $('#rightDatePicker').data('DateTimePicker').minDate(e.date);
  });
  $('#rightDatePicker').on('dp.change', function (e) {
    $('#leftDatePicker').data('DateTimePicker').maxDate(e.date);
  });
});

/* Hide 'bank' field is the paymentType != 'Transferencia'
Hide 'reference number' field is the paymentType == 'Efectivo */
var paymentType = document.getElementById("paymentType");

paymentType.onchange = function(){
  var bank = document.getElementById("bank");
  var referenceNumber = document.getElementById("referenceNumber");
  bank.style.display = (this.value != "Transferencia") ? "none":"block";
  referenceNumber.style.display = (this.value == "Efectivo") ? "none":"block";
};
