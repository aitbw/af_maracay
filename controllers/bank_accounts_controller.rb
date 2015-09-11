def asignar_cuenta
  query = Teacher.find(params[:profesor])

  @cuentas = Account.new(idProfesor: params[:profesor], idBanco: params[:banco], numeroCuenta: params[:numero], tipoCuenta: params[:tipo])

  if @cuentas.save
    redirect '/dashboard/teachers', notice: "Cuenta asignada a #{query.nombreProfesor}"
  else
    redirect '/dashboard/teachers', error: 'Ha ocurrido un error, intente nuevamente.'
  end
end
