def nuevo_curso
  new_course = Curso.new(idTipoCurso: params[:tipo], nivelCurso: params[:nivel], capacidadCurso: params[:capacidad], inicioCurso: params[:inicio], finCurso: params[:fin], horasCurso: params[:horas])

  if new_course.save
    redirect '/dashboard/courses', notice: 'Curso creado exitosamente.'
  else
    redirect '/dashboard/courses/new_course', error: 'Ha ocurrido un error, intente nuevamente.'
  end
end
