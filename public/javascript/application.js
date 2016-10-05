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

$(function () {
  document.getElementById('usersTable').addEventListener('click', toggleLock, true);

  function toggleLock(element) {
    var userId = element.target.dataset.userId
    var lockOptions = {
      url: '/dashboard/users/' + userId + '/lock_account',
      idToShow: 'unlock_account_' + userId,
      label: 'Bloqueada'
    }
    var unlockOptions = {
      url: '/dashboard/users/' + userId + '/unlock_account',
      idToShow: 'lock_account_' + userId,
      label: 'Desbloqueada'
    }
    
    if (element.target.id === unlockOptions.idToShow) {
      ajaxToggleLock(lockOptions, userId, element)
    } else if (element.target.id === lockOptions.idToShow) {
      ajaxToggleLock(unlockOptions, userId, element)
    }
  }

  function ajaxToggleLock(options, userId, element) {
    $.ajax({
      method: 'PUT',
      url: options.url
    }).done(function(data) {
      element.target.parentElement.className = 'hidden'
      document.getElementById(options.idToShow).parentElement.className = 'show'
      document.getElementById('status_' + userId).innerHTML = options.label
      toastr.success(data.message)
    }).fail(function(error) {
      toastr.error(error.responseText)
    })
  }
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
