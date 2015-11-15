def new_student
  new_student = Student.new(params[:student])

  if new_student.save
    redirect '/dashboard/students', notice: 'Estudiante creado exitosamente.'
  else
    flash[:errors] = new_student.errors.full_messages
    redirect '/dashboard/students/new_student'
  end
end
