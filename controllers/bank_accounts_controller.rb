def asignar_cuenta
  new_account = Account.new(params[:cuenta])

  if new_account.save
    redirect "/dashboard/teachers/bank_accounts/#{params[:id]}", notice: 'Cuenta asignada exitosamente.'
  else
    redirect "/dashboard/teachers/bank_accounts/#{params[:id]}/add", flash[:error] = new_account.errors.full_messages
  end
end
