def assign_account
  new_account = BankAccount.new(params[:account])

  if new_account.save
    flash[:notice] = 'Cuenta asignada exitosamente.'
    redirect "/dashboard/teachers/#{params[:id]}/bank_accounts"
  else
    flash[:errors] = new_account.errors.full_messages
    redirect "#{request.path_info}"
  end
end
