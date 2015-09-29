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
  erb :new_course, layout: :'layouts/dashboard'
end

post '/dashboard/courses/new_course' do
  nuevo_curso
end

get '/dashboard/courses/delete/:id' do
  begin
    Curso.find(params[:id]).present?
  rescue ActiveRecord::RecordNotFound
    redirect '/dashboard/courses', error: 'El curso no existe.'
  else
    @id_curso = params[:id]
    @query = Curso.find(params[:id])
    titulo('Eliminar curso')
    erb :delete_course, layout: :'layouts/dashboard'
  end
end

delete '/delete_course/:id' do
  if Curso.destroy(params[:id])
    redirect '/dashboard/courses', notice: 'Curso eliminado.'
  else
    redirect "/dashboard/courses/delete/#{params[:id]}", error: 'Ha ocurrido un error, intente nuevamente.'
  end
end

get '/dashboard/courses/edit/:id' do
  begin
    Curso.find(params[:id]).present?
  rescue ActiveRecord::RecordNotFound
    redirect '/dashboard/courses', error: 'El curso no existe.'
  else
    @id_curso = params[:id]
    @query = Curso.find(params[:id])
    @tipos = Tipo.all
    @sedes = Sede.all
    titulo('Editar curso')
    erb :edit_course, layout: :'layouts/dashboard'
  end
end

put '/edit_course/:id' do
  edit_course = Curso.find(params[:id])

  if (params[:codigo] || params[:nivel] || params[:capacidad]).blank?
    redirect "/dashboard/courses/edit/#{params[:id]}", error: 'Debe completar todos los campos.'
  end

  if edit_course.codigoCurso == params[:codigo]
    edit_course.codigoCurso = edit_course.codigoCurso
  elsif Curso.where(codigoCurso: params[:codigo]).present?
    redirect "/dashboard/courses/edit/#{params[:id]}", error: 'El código ya se encuentra en uso.'
  else
    edit_course.codigoCurso = params[:codigo]
  end

  edit_course.idTipoCurso = params[:tipo]
  edit_course.idSede = params[:sede]
  edit_course.nivelCurso = params[:nivel]
  edit_course.capacidadCurso = params[:capacidad]

  if edit_course.save
    redirect '/dashboard/courses', notice: 'Datos actualizados.'
  else
    redirect "/dashboard/courses/edit/#{params[:id]}", error: 'Ha ocurrido un error, intente nuevamente.'
  end
end
