def new_course
  new_course = Course.new(params[:course])

  if new_course.save
    redirect '/dashboard/courses', notice: 'Curso creado exitosamente.'
  else
    flash[:errors] = new_course.errors.full_messages
    redirect(request.path_info.to_s)
  end
end

def delete_course(id)
  if Course.destroy(id)
    redirect '/dashboard/courses', notice: 'Curso eliminado.'
  else
    flash[:error] = 'Ha ocurrido un error, intente nuevamente.'
    redirect(request.path_info.to_s)
  end
end

def edit_course(id)
  edit_course = Course.find(id)

  if edit_course.update(params[:course])
    redirect '/dashboard/courses', notice: 'Datos actualizados.'
  else
    flash[:errors] = edit_course.errors.full_messages
    redirect(request.path_info.to_s)
  end
end
