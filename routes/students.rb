get '/dashboard/students' do
  titulo('Estudiantes')
  @estudiantes = Estudiante.all
  erb :students, layout: :'layouts/dashboard'
end

get '/dashboard/students/new_student' do
  titulo('Crear nuevo estudiante')
  @cursos = Curso.select(:idCurso, :codigoCurso)
  erb :new_student, layout: :'layouts/dashboard'
end

post '/dashboard/students/new_student' do
  nuevo_estudiante
end

get '/dashboard/students/delete/:id' do
  begin
    Estudiante.find(params[:id]).present?
  rescue ActiveRecord::RecordNotFound
    redirect '/dashboard/students', error: 'El estudiante no existe.'
  else
    @id_estudiante = params[:id]
    @query = Estudiante.find(params[:id])
    titulo('Eliminar estudiante')
    erb :delete_student, layout: :'layouts/dashboard'
  end
end

delete '/delete_student/:id' do
  if Estudiante.destroy(params[:id])
    redirect '/dashboard/students', notice: 'Estudiante eliminado.'
  else
    redirect "/dashboard/students/delete/#{params[:id]}", error: 'Ha ocurrido un error, intente nuevamente.'
  end
end

get '/dashboard/students/edit/:id' do
  begin
    Estudiante.find(params[:id]).present?
  rescue ActiveRecord::RecordNotFound
    redirect '/dashboard/students', error: 'El estudiante no existe.'
  else
    @id_estudiante = params[:id]
    @estudiante = Estudiante.find(params[:id])
    titulo('Editar estudiante')
    erb :edit_student, layout: :'layouts/dashboard'
  end
end

put '/edit_student/:id' do
  e = Estudiante.find(params[:id])

  e.update(params[:estudiante])

  if e.save
    redirect '/dashboard/students', notice: 'Datos actualizados.'
  else
    redirect "/dashboard/students/edit/#{params[:id]}", flash[:error] = e.errors.full_messages
  end
end
