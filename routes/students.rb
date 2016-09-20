get '/dashboard/students' do
  set_page_title('Estudiantes')
  @students = Student.search_student(params[:cedula]).page(params[:page])
  erb :students, user_layout
end

get '/dashboard/students/new_student' do
  set_page_title('Crear nuevo estudiante')
  @sections = Section.where('section_hours != ? AND is_finished = ?', 0, false)
  erb :'new/new_student', user_layout
end

post '/dashboard/students/new_student' do
  new_student
end

get '/dashboard/students/:id/delete' do
  set_page_title('Eliminar estudiante')
  @student = Student.find(params[:id])
  erb :'delete/delete_student', user_layout
end

delete '/dashboard/students/:id/delete' do
  if Student.destroy(params[:id])
    redirect '/dashboard/students', notice: 'Estudiante eliminado.'
  else
    flash[:error] = 'Ha ocurrido un error, intente nuevamente.'
    redirect(request.path_info.to_s)
  end
end

get '/dashboard/students/:id/edit' do
  set_page_title('Editar estudiante')
  @student = Student.find(params[:id])
  erb :'edit/edit_student', user_layout
end

put '/dashboard/students/:id/edit' do
  edit_student = Student.find(params[:id])

  if edit_student.update(params[:student])
    redirect '/dashboard/students', notice: 'Datos actualizados.'
  else
    flash[:errors] = edit_student.errors.full_messages
    redirect(request.path_info.to_s)
  end
end

get '/dashboard/students/:id/grades' do
  set_page_title('Calificaciones')
  @student = Student.find(params[:id])
  @grades = Grade.where(student_id: params[:id]).includes(:course).paginate(page: params[:page])
  erb :grades, user_layout
end
