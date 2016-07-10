get '/dashboard/courses' do
  set_page_title('Cursos')
  @courses = Course.search_course(
  params[:code]).paginate(page: params[:page]).includes(:course_type, :office)
  @course_types = CourseType.all
  erb :courses, user_layout
end

get '/dashboard/courses/new_course' do
  set_page_title('Crear nuevo curso')
  @types = CourseType.select(:course_type_id, :course_name)
  @offices = Office.all
  erb :'new/new_course', user_layout
end

post '/dashboard/courses/new_course' do
  new_course
end

get '/dashboard/courses/:id/delete' do
  @course = Course.find(params[:id])
  set_page_title('Eliminar curso')
  erb :'delete/delete_course', user_layout
end

delete '/dashboard/courses/:id/delete' do
  if Course.destroy(params[:id])
    redirect '/dashboard/courses', notice: 'Curso eliminado.'
  else
    flash[:error] = 'Ha ocurrido un error, intente nuevamente.'
    redirect "#{request.path_info}"
  end
end

get '/dashboard/courses/:id/edit' do
  @course = Course.find(params[:id])
  @types = CourseType.all
  @offices = Office.all
  set_page_title('Editar curso')
  erb :'edit/edit_course', user_layout
end

put '/dashboard/courses/:id/edit' do
  edit_course = Course.find(params[:id])

  if edit_course.update(params[:course])
    redirect '/dashboard/courses', notice: 'Datos actualizados.'
  else
    flash[:errors] = edit_course.errors.full_messages
    redirect "#{request.path_info}"
  end
end

get '/dashboard/courses/:id/students/show' do
  set_page_title('Estudiantes del curso')
  @course = Course.find(params[:id])
  erb :course_students, user_layout
end

get '/dashboard/courses/:id/grades/assign' do
  set_page_title('Asignar calificaciones')
  @course = Course.find(params[:id])
  erb :'assign/assign_grades', user_layout
end

post '/dashboard/courses/:id/grades/assign' do
  batch_grade_assignment
end
