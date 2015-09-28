def nuevo_profesor
  new_teacher = Teacher.new(params[:profesor])

  if new_teacher.save
    redirect '/dashboard/teachers', notice: 'Profesor creado exitosamente.'
  else
    redirect '/dashboard/teachers/new_teacher', error: 'Ha ocurrido un error, intente nuevamente.'
  end
end
