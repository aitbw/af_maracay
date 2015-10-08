get '/dashboard/students' do
  titulo('Estudiantes')
  @students = Estudiante.all
  erb :students, layout: :'layouts/dashboard'
end

get '/dashboard/students/new_student' do
  titulo('Crear nuevo estudiante')
  @courses = Curso.select(:idCurso, :codigoCurso)
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
    @query = Estudiante.find(params[:id])
    titulo('Editar estudiante')
    erb :edit_student, layout: :'layouts/dashboard'
  end
end

put '/edit_student/:id' do
  edit_student = Estudiante.find(params[:id])

  edit_student.update(params[:estudiante])

  if edit_student.save
    redirect '/dashboard/students', notice: 'Datos actualizados.'
  else
    redirect "/dashboard/students/edit/#{params[:id]}", flash[:error] = edit_student.errors.full_messages
  end
end

get '/dashboard/students/signups/:id' do
  begin
    Estudiante.find(params[:id]).present?
  rescue ActiveRecord::RecordNotFound
    redirect '/dashboard/students', error: 'El estudiante no existe.'
  else
    @id_estudiante = params[:id]
    @signups = Inscripcion.where(idEstudiante: params[:id])
    titulo('Inscripciones')
    erb :signups, layout: :'layouts/dashboard'
  end
end

get '/dashboard/students/signups/:id/add' do
  begin
    Estudiante.find(params[:id]).present?
  rescue ActiveRecord::RecordNotFound
    redirect '/dashboard/students', error: 'El estudiante no existe.'
  else
    @id_estudiante = params[:id]
    @js = ['moment.min.js', 'bootstrap-datetimepicker.min.js']
    @banks = Banco.all
    titulo('Nueva inscripción')
    erb :new_signup, layout: :'layouts/dashboard'
  end
end

post '/dashboard/students/signups/:id/add' do
  new_signup = Inscripcion.new(params[:inscripcion])

  if new_signup.save
    redirect "/dashboard/students/signups/#{params[:id]}", notice: 'Inscripción generada exitosamente.'
  else
    redirect "/dashboard/students/signups/#{params[:id]}/add", flash[:error] = new_signup.errors.full_messages
  end
end
