def asignar_cuenta
  query = Teacher.find(params[:id])

  new_account = Account.new(params[:cuenta])

  if new_account.save
    redirect "/dashboard/teachers/bank_accounts/#{params[:id]}", notice: "Cuenta asignada a #{query.nombreProfesor}"
  else
    redirect "/dashboard/teachers/bank_accounts/#{params[:id]}/add", error: 'Ha ocurrido un error, intente nuevamente.'
  end
end
