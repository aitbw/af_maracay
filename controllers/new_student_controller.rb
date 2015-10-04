def nuevo_estudiante
  new_student = Estudiante.new(params[:estudiante])

  if new_student.save
    redirect '/dashboard/students', notice: 'Estudiante creado exitosamente.'
  else
    redirect '/dashboard/students/new_student', flash[:error] = new_student.errors.full_messages
  end
end
