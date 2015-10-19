def nuevo_profesor
  new_teacher = Teacher.new(params[:profesor])

  if new_teacher.save
    redirect '/dashboard/teachers', notice: 'Profesor creado exitosamente.'
  else
    flash[:error] = new_teacher.errors.full_messages
    redirect '/dashboard/teachers/new_teacher'
  end
end
