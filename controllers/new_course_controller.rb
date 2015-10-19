def nuevo_curso
  new_course = Curso.new(params[:curso])

  if new_course.save
    redirect '/dashboard/courses', notice: 'Curso creado exitosamente.'
  else
    flash[:error] = new_course.errors.full_messages
    redirect '/dashboard/courses/new_course'
  end
end
