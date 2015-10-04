def nuevo_profesor
  new_teacher = Teacher.new(params[:profesor])

  if new_teacher.save
    redirect '/dashboard/teachers', notice: 'Profesor creado exitosamente.'
  else
    redirect '/dashboard/teachers/new_teacher', flash[:error] = new_teacher.errors.full_messages
  end
end
