def new_bank_account
  new_account = BankAccount.new(params[:account])

  if new_account.save
    redirect "/dashboard/teachers/#{params[:id]}/bank_accounts", notice: 'Cuenta creada exitosamente.'
  else
    flash[:errors] = new_account.errors.full_messages
    redirect(request.path_info.to_s)
  end
end

def delete_bank_account
  if BankAccount.destroy(params[:account])
    flash[:notice] = 'Cuenta bancaria eliminada.'
    redirect "/dashboard/teachers/#{params[:teacher]}/bank_accounts"
  else
    flash[:error] = 'Ha ocurrido un error, intente nuevamente.'
    redirect(request.path_info.to_s)
  end
end

def edit_bank_account(edit_account)
  if edit_account.update(params[:form])
    redirect "/dashboard/teachers/#{params[:teacher]}/bank_accounts", notice: 'Datos actualizados.'
  else
    flash[:errors] = edit_account.errors.full_messages
    redirect(request.path_info.to_s)
  end
end
