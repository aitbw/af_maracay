def asignar_cuenta
  new_account = Account.new(params[:cuenta])

  if new_account.save
    flash[:notice] = 'Cuenta asignada exitosamente.'
    redirect "/dashboard/teachers/#{params[:id]}/bank_accounts"
  else
    flash[:error] = new_account.errors.full_messages
    redirect "/dashboard/teachers/#{params[:id]}/bank_accounts/add"
  end
end
