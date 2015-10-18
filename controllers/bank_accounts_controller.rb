def asignar_cuenta
  new_account = Account.new(params[:cuenta])

  if new_account.save
    redirect "/dashboard/teachers/#{params[:id]}/bank_accounts", notice: 'Cuenta asignada exitosamente.'
  else
    redirect "/dashboard/teachers/#{params[:id]}/bank_accounts/add", flash[:error] = new_account.errors.full_messages
  end
end
