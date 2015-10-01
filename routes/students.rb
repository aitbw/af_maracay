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
  EMAIL_REGEX ||= /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  if params[:nombre].blank?
    redirect "/dashboard/students/edit/#{params[:id]}", error: 'Debe completar todos los campos.'
  else
    e.nombreEstudiante = params[:nombre]
  end

  if e.correoEstudiante == params[:correo]
    e.correoEstudiante = e.correoEstudiante
  elsif EMAIL_REGEX.match(params[:correo]).nil?
    redirect "/dashboard/students/edit/#{params[:id]}", error: 'Correo inválido.'
  elsif Estudiante.where(correoEstudiante: params[:correo]).present?
    redirect "/dashboard/students/edit/#{params[:id]}", error: 'El correo ya existe.'
  else
    e.correoEstudiante = params[:correo]
  end

  if e.cedulaEstudiante == params[:cedula]
    e.cedulaEstudiante = e.cedulaEstudiante
  elsif /\d{6,8}/.match(params[:cedula]).nil?
    redirect "/dashboard/students/edit/#{params[:id]}", error: 'Cédula inválida.'
  elsif Estudiante.where(cedulaEstudiante: params[:cedula]).present?
    redirect "/dashboard/students/edit/#{params[:id]}", error: 'La cédula ya existe.'
  else
    e.cedulaEstudiante = params[:cedula]
  end

  if /\d{4}-?\d{7}/.match(params[:telefono]).nil?
    redirect "/dashboard/students/edit/#{params[:id]}", error: 'Número inválido'
  else
    e.telefonoEstudiante = params[:telefono]
  end

  if e.save
    redirect '/dashboard/students', notice: 'Datos actualizados.'
  else
    redirect "/dashboard/students/edit/#{params[:id]}", error: 'Ha ocurrido un error, intente nuevamente.'
  end
end
