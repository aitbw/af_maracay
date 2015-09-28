def nuevo_profesor
  new_teacher = Teacher.new(nombreProfesor: params[:nombre], correoProfesor: params[:correo], telefonoProfesor: params[:telefono], cedulaProfesor: params[:cedula], fechaIngreso: params[:ingreso])

  if new_teacher.save
    redirect '/dashboard/teachers', notice: 'Profesor creado exitosamente.'
  else
    redirect '/dashboard/teachers/new_teacher', error: 'Ha ocurrido un error, intente nuevamente.'
  end
end
