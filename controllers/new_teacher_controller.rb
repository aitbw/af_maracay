def new_teacher
  new_teacher = Teacher.new(params[:teacher])

  if new_teacher.save
    redirect '/dashboard/teachers', notice: 'Profesor creado exitosamente.'
  else
    flash[:errors] = new_teacher.errors.full_messages
    redirect '/dashboard/teachers/new_teacher'
  end
end
