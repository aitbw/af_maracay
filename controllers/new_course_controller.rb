def new_course
  new_course = Course.new(params[:course])

  if new_course.save
    redirect '/dashboard/courses', notice: 'Curso creado exitosamente.'
  else
    flash[:errors] = new_course.errors.full_messages
    redirect "#{request.path_info}"
  end
end
