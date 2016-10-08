get '/dashboard/courses' do
  set_page_title('Cursos')
  @courses = Course.search_course(params[:code]).page(params[:page]).includes(:course_type, :office)
  @course_types = CourseType.all
  erb :'courses/courses', user_layout
end

get '/dashboard/courses/new_course' do
  set_page_title('Crear nuevo curso')
  @types = CourseType.select(:course_type_id, :course_modality)
  @offices = Office.all
  erb :'courses/new_course', user_layout
end

post '/dashboard/courses/new_course' do
  new_course
end

get '/dashboard/courses/:id/delete' do
  set_page_title('Eliminar curso')
  @course = Course.find(params[:id])
  erb :'courses/delete_course', user_layout
end

delete '/dashboard/courses/:id/delete' do
  delete_course(params[:id])
end

get '/dashboard/courses/:id/edit' do
  set_page_title('Editar curso')
  @course = Course.find(params[:id])
  @types = CourseType.all
  @offices = Office.all
  erb :'courses/edit_course', user_layout
end

put '/dashboard/courses/:id/edit' do
  edit_course(params[:id])
end

get '/dashboard/courses/:id/grades/assign' do
  set_page_title('Asignar calificaciones')
  @course = Course.find(params[:id])
  erb :'grades/assign_grades', user_layout
end

post '/dashboard/courses/:id/grades/assign' do
  batch_grade_assignment
end
