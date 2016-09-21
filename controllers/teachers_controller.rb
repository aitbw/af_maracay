def new_teacher
  new_teacher = Teacher.new(params[:teacher])

  if new_teacher.save
    redirect '/dashboard/teachers', notice: 'Profesor creado exitosamente.'
  else
    flash[:errors] = new_teacher.errors.full_messages
    redirect(request.path_info.to_s)
  end
end

def delete_teacher(id)
  if Teacher.destroy(id)
    redirect '/dashboard/teachers', notice: 'Profesor eliminado.'
  else
    flash[:error] = 'Ha ocurrido un error, intente nuevamente.'
    redirect(request.path_info.to_s)
  end
end

def edit_teacher(id)
  edit_teacher = Teacher.find(id)

  if edit_teacher.update(params[:teacher])
    redirect '/dashboard/teachers', notice: 'Datos actualizados.'
  else
    flash[:errors] = edit_teacher.errors.full_messages
    redirect(request.path_info.to_s)
  end
end
