def asignar_cuenta
  query = Teacher.find(params[:id])

  @cuentas = Account.new(idProfesor: params[:id], idBanco: params[:banco], numeroCuenta: params[:numero], tipoCuenta: params[:tipo])

  if @cuentas.save
    redirect '/dashboard/teachers', notice: "Cuenta asignada a #{query.nombreProfesor}"
  else
    redirect '/dashboard/teachers', error: 'Ha ocurrido un error, intente nuevamente.'
  end
end
