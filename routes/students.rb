# Helpers to keep exception handling DRY
def find_student(id)
  Estudiante.find(id).present?
rescue ActiveRecord::RecordNotFound
  redirect '/dashboard/students', error: 'El estudiante no existe.'
end

def find_signup(estudiante, inscripcion)
  Signup.find(inscripcion).present?
rescue ActiveRecord::RecordNotFound
  redirect "/dashboard/students/signups/#{estudiante}", error: 'La inscripción asociada no existe.'
end

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
  if find_student(params[:id])
    @id_estudiante = params[:id]
    @query = Estudiante.find(params[:id])
    titulo('Eliminar estudiante')
    erb :delete_student, layout: :'layouts/dashboard'
  end
end

delete '/delete_student/:id' do
  if find_student(params[:id])
    Estudiante.destroy(params[:id])
    redirect '/dashboard/students', notice: 'Estudiante eliminado.'
  else
    redirect "/dashboard/students/delete/#{params[:id]}", error: 'Ha ocurrido un error, intente nuevamente.'
  end
end

get '/dashboard/students/edit/:id' do
  if find_student(params[:id])
    @id_estudiante = params[:id]
    @query = Estudiante.find(params[:id])
    titulo('Editar estudiante')
    erb :edit_student, layout: :'layouts/dashboard'
  end
end

put '/edit_student/:id' do
  if find_student(params[:id])
    edit_student = Estudiante.find(params[:id])
    edit_student.update(params[:estudiante])
    redirect '/dashboard/students', notice: 'Datos actualizados.' if edit_student.save
  else
    redirect "/dashboard/students/edit/#{params[:id]}", flash[:error] = edit_student.errors.full_messages
  end
end

get '/dashboard/students/signups/:id' do
  if find_student(params[:id])
    @id_estudiante = params[:id]
    @signups = Signup.where(idEstudiante: params[:id])
    titulo('Inscripciones')
    erb :signups, layout: :'layouts/dashboard'
  end
end

get '/dashboard/students/signups/:id/add' do
  if find_student(params[:id])
    @id_estudiante = params[:id]
    @js = ['moment.min.js', 'bootstrap-datetimepicker.min.js']
    @banks = Banco.all
    titulo('Nueva inscripción')
    erb :new_signup, layout: :'layouts/dashboard'
  end
end

post '/dashboard/students/signups/:id/add' do
  if find_student(params[:id])
    new_signup = Signup.new(params[:inscripcion])

    if new_signup.save
      redirect "/dashboard/students/signups/#{params[:id]}", notice: 'Inscripción generada exitosamente.'
    else
      redirect "/dashboard/students/signups/#{params[:id]}/add", flash[:error] = new_signup.errors.full_messages
    end
  end
end

get '/dashboard/students/signups/:idE/delete/:idS' do
  if find_student(params[:idE]) && find_signup(params[:idE], params[:idS])
    titulo('Eliminar inscripción')
    @id_estudiante = params[:idE]
    @id_inscripcion = params[:idS]
    @query = Signup.find(params[:idS])
    erb :delete_signup, layout: :'layouts/dashboard'
  end
end

delete '/:idE/delete_signup/:idS' do
  if find_student(params[:idE]) && find_signup(params[:idE], params[:idS])
    Signup.destroy(params[:idS])
    redirect "/dashboard/students/signups/#{params[:idE]}", notice: 'Inscripción eliminada.'
  else
    redirect "/dashboard/students/signups/#{params[:idE]}/delete/#{params[:idS]}", error: 'Ha ocurrido un error, intente nuevamente.'
  end
end

get '/dashboard/students/signups/:idE/edit/:idS' do
  if find_student(params[:idE]) && find_signup(params[:idE], params[:idS])
    titulo('Editar inscripción')
    @id_estudiante = params[:idE]
    @id_inscripcion  = params[:idS]
    @query = Signup.find(params[:idS])
    @banks = Banco.all
    erb :edit_signup, layout: :'layouts/dashboard'
  end
end

put '/:idE/edit_signup/:idS' do
  if find_student(params[:idE]) && find_signup(params[:idE], params[:idS])
    edit_signup = Signup.find(params[:idS])
    edit_signup.update(params[:inscripcion])
    redirect "/dashboard/students/signups/#{params[:idE]}", notice: 'Datos actualizados.' if edit_signup.save
  else
    redirect "/dashboard/students/signups/#{params[:idE]}/edit/#{params[:idS]}", flash[:error] = edit_signup.errors.full_messages
  end
end
