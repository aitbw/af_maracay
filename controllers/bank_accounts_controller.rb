def asignar_cuenta
  query = Teacher.find(params[:id])

  if Account.where(idBanco: params[:banco], numeroCuenta: params[:numero]).present?
    redirect "/dashboard/teachers/bank_accounts/#{params[:id]}/add", error: 'Esta cuenta ya existe.'
  else
    new_account = Account.new(idProfesor: params[:id], idBanco: params[:banco], numeroCuenta: params[:numero], tipoCuenta: params[:tipo])
  end

  if new_account.save
    redirect "/dashboard/teachers/bank_accounts/#{params[:id]}", notice: "Cuenta asignada a #{query.nombreProfesor}"
  else
    redirect "/dashboard/teachers/bank_accounts/#{params[:id]}/add", error: 'Ha ocurrido un error, intente nuevamente.'
  end
end
