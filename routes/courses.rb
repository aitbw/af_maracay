get '/dashboard/courses' do
  titulo('Cursos — Panel de control')
  @courses = Course.all
  @types = Type.all
  erb :courses, layout: :'layouts/dashboard'
end

get '/dashboard/courses/new_course' do
  titulo('Crear nuevo curso — Panel de control')
  @types = Type.select(:idTipoCurso, :tipoCurso)
  erb :new_course, layout: :'layouts/dashboard'
end

post '/dashboard/courses/new_course' do
  nuevo_curso
end

get '/dashboard/courses/delete/:id' do
  begin
    Course.find(params[:id]).present?
  rescue ActiveRecord::RecordNotFound
    redirect '/dashboard/courses', error: 'El curso no existe.'
  else
    @id_curso = params[:id]
    @query = Course.find(params[:id])
    titulo('Eliminar curso — Panel de control')
    erb :delete_course, layout: :'layouts/dashboard'
  end
end

delete '/delete_course/:id' do
  if Course.destroy(params[:id])
    redirect '/dashboard/courses', notice: 'Curso eliminado.'
  else
    redirect "/dashboard/courses/delete/#{params[:id]}", error: 'Ha ocurrido un error, intente nuevamente.'
  end
end

get '/dashboard/courses/edit/:id' do
  begin
    Course.find(params[:id]).present?
  rescue ActiveRecord::RecordNotFound
    redirect '/dashboard/courses', error: 'El curso no existe.'
  else
    @id_curso = params[:id]
    @query = Course.find(params[:id])
    @tipos = Type.all
    titulo('Editar curso — Panel de control')
    erb :edit_course, layout: :'layouts/dashboard'
  end
end

put '/edit_course/:id' do
  edit_course = Course.find(params[:id])

  if (params[:nivel] || params[:capacidad] || params[:inicio] || params[:fin] || params[:horas]).blank?
    redirect "/dashboard/courses/edit/#{params[:id]}", error: 'Debe completar todos los campos.'
  end

  edit_course.idTipoCurso = params[:tipo]
  edit_course.nivelCurso = params[:nivel]
  edit_course.capacidadCurso = params[:capacidad]
  edit_course.inicioCurso = params[:inicio]
  edit_course.finCurso = params[:fin]
  edit_course.horasCurso = params[:horas]

  if edit_course.save
    redirect '/dashboard/courses', notice: 'Datos actualizados.'
  else
    redirect "/dashboard/courses/edit/#{params[:id]}", error: 'Ha ocurrido un error, intente nuevamente.'
  end
end
