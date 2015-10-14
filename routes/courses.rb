# Helper to keep exception handling DRY
def find_course(id)
  Curso.find(id).present?
rescue ActiveRecord::RecordNotFound
  redirect '/dashboard/courses', error: 'El curso no existe.'
end

get '/dashboard/courses' do
  titulo('Cursos')
  @courses = Curso.all
  @tipos = Tipo.all
  erb :courses, layout: :'layouts/dashboard'
end

get '/dashboard/courses/new_course' do
  titulo('Crear nuevo curso')
  @tipos = Tipo.select(:idTipoCurso, :tipoCurso)
  @sedes = Sede.all
  @js = ['moment.min.js', 'bootstrap-datetimepicker.min.js']
  erb :new_course, layout: :'layouts/dashboard'
end

post '/dashboard/courses/new_course' do
  nuevo_curso
end

get '/dashboard/courses/delete/:id' do
  if find_course(params[:id])
    @id_curso = params[:id]
    @query = Curso.find(params[:id])
    titulo('Eliminar curso')
    erb :delete_course, layout: :'layouts/dashboard'
  end
end

delete '/delete_course/:id' do
  if find_course(params[:id])
    Curso.destroy(params[:id])
    redirect '/dashboard/courses', notice: 'Curso eliminado.'
  else
    redirect "/dashboard/courses/delete/#{params[:id]}", error: 'Ha ocurrido un error, intente nuevamente.'
  end
end

get '/dashboard/courses/edit/:id' do
  if find_course(params[:id])
    @id_curso = params[:id]
    @query = Curso.find(params[:id])
    @tipos = Tipo.all
    @sedes = Sede.all
    titulo('Editar curso')
    erb :edit_course, layout: :'layouts/dashboard'
  end
end

put '/edit_course/:id' do
  if find_course(params[:id])
    edit_course = Curso.find(params[:id])
    edit_course.update(params[:curso])
    redirect '/dashboard/courses', notice: 'Datos actualizados.' if edit_course.save
  else
    redirect "/dashboard/courses/edit/#{params[:id]}", flash[:error] = edit_course.errors.full_messages
  end
end
