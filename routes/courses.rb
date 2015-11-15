# Helper to keep exception handling DRY
def find_course(id)
  Course.find(id).present?
rescue ActiveRecord::RecordNotFound
  redirect '/dashboard/courses', error: 'El curso no existe.'
end

before %r{\/(delete|edit)_course\/(\d)} do |_, id|
  find_course(id)
end

get '/dashboard/courses' do
  set_page_title('Cursos')
  @courses = Course.all
  @types = CourseType.all
  erb :courses, layout: :'layouts/dashboard'
end

get '/dashboard/courses/new_course' do
  set_page_title('Crear nuevo curso')
  @types = CourseType.select(:course_type_id, :course_type)
  @offices = Office.all
  @js = ['moment.min.js', 'bootstrap-datetimepicker.min.js']
  erb :new_course, layout: :'layouts/dashboard'
end

post '/dashboard/courses/new_course' do
  new_course
end

get '/dashboard/courses/:id/delete' do
  if find_course(params[:id])
    @course_id = params[:id]
    @course = Course.find(params[:id])
    set_page_title('Eliminar curso')
    erb :delete_course, layout: :'layouts/dashboard'
  end
end

delete '/delete_course/:id' do
  if Course.destroy(params[:id])
    redirect '/dashboard/courses', notice: 'Curso eliminado.'
  else
    flash[:error] = 'Ha ocurrido un error, intente nuevamente.'
    redirect "/dashboard/courses/#{params[:id]}/delete"
  end
end

get '/dashboard/courses/:id/edit' do
  if find_course(params[:id])
    @course_id = params[:id]
    @course = Course.find(params[:id])
    @types = CourseType.all
    @offices = Office.all
    set_page_title('Editar curso')
    erb :edit_course, layout: :'layouts/dashboard'
  end
end

put '/edit_course/:id' do
  edit_course = Course.find(params[:id])
  edit_course.update(params[:course])
  if edit_course.save
    redirect '/dashboard/courses', notice: 'Datos actualizados.'
  else
    flash[:errors] = edit_course.errors.full_messages
    redirect "/dashboard/courses/#{params[:id]}/edit"
  end
end
