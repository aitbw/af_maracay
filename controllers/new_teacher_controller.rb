def nuevo_profesor
  fecha = Time.now.strftime('%d/%m/%Y')

  @profesores = Teacher.new(nombreProfesor: params[:nombre], correoProfesor: params[:correo], telefonoProfesor: params[:telefono], cedulaProfesor: params[:cedula], fechaIngreso: fecha)

  if @profesores.save
    redirect '/dashboard/teachers/new_teacher', notice: 'Profesor creado exitosamente.'
  else
    redirect '/dashboard/teachers/new_teacher', notice: 'Ha ocurrido un error, intente nuevamente.'
  end
end
