def asignar_cuenta
  @nombre = Teacher.where(idProfesor: params[:profesor]).pluck(:nombreProfesor).to_s.gsub(/^\["|\"\]$/, '')

  @cuentas = Account.new(idProfesor: params[:profesor], idBanco: params[:banco], numeroCuenta: params[:numero], tipoCuenta: params[:tipo])

  if @cuentas.save
    redirect '/dashboard/teachers', notice: "Cuenta asignada a #{@nombre}"
  else
    redirect '/dashboard/teachers', error: 'Ha ocurrido un error, intente nuevamente.'
  end
end
