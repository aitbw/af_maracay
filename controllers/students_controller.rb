def new_student
  new_student = Student.new(params[:student])

  if new_student.save
    redirect '/dashboard/students', notice: 'Estudiante creado exitosamente.'
  else
    flash[:errors] = new_student.errors.full_messages
    redirect(request.path_info.to_s)
  end
end

def delete_student(id)
  if Student.destroy(id)
    redirect '/dashboard/students', notice: 'Estudiante eliminado.'
  else
    flash[:error] = 'Ha ocurrido un error, intente nuevamente.'
    redirect(request.path_info.to_s)
  end
end

def edit_student(id)
  edit_student = Student.find(id)

  if edit_student.update(params[:student])
    redirect '/dashboard/students', notice: 'Datos actualizados.'
  else
    flash[:errors] = edit_student.errors.full_messages
    redirect(request.path_info.to_s)
  end
end
