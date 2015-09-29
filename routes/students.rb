get '/dashboard/students' do
  titulo('Estudiantes — Panel de control')
  @estudiantes = Estudiante.all
  erb :students, layout: :'layouts/dashboard'
end

get '/dashboard/students/new_student' do
  titulo('Crear nuevo estudiante — Panel de control')
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
    titulo('Eliminar estudiante — Panel de control')
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
