# Helpers to keep exception handling DRY
def find_student(id)
  Estudiante.find(id).present?
rescue ActiveRecord::RecordNotFound
  redirect '/dashboard/students', error: 'El estudiante no existe.'
end

def find_signup(estudiante, inscripcion)
  Signup.find(inscripcion).present?
rescue ActiveRecord::RecordNotFound
  flash[:error] = 'La inscripción asociada no existe.'
  redirect "/dashboard/students/#{estudiante}/signups"
end

before %r{\/(delete|edit)_student\/(\d)} do |_action, id|
  find_student(id)
end

before %r{\/(\d)\/(delete|edit)_signup\/(\d)} do |estudiante, _action, inscripcion|
  find_student(estudiante) && find_signup(estudiante, inscripcion)
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

get '/dashboard/students/:id/delete' do
  if find_student(params[:id])
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
    flash[:error] = 'Ha ocurrido un error, intente nuevamente.'
    redirect "/dashboard/students/#{params[:id]}/delete"
  end
end

get '/dashboard/students/:id/edit' do
  if find_student(params[:id])
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
    flash[:error] = edit_student.errors.full_messages
    redirect "/dashboard/students/edit/#{params[:id]}"
  end
end

get '/dashboard/students/:id/signups' do
  if find_student(params[:id])
    @id_estudiante = params[:id]
    @signups = Signup.where(idEstudiante: params[:id]).order(fechaEmision: :desc)
    titulo('Inscripciones')
    erb :signups, layout: :'layouts/dashboard'
  end
end

get '/dashboard/students/:id/signups/add' do
  if find_student(params[:id])
    @id_estudiante = params[:id]
    @js = ['moment.min.js', 'bootstrap-datetimepicker.min.js']
    @banks = Banco.all
    titulo('Nueva inscripción')
    erb :new_signup, layout: :'layouts/dashboard'
  end
end

post '/dashboard/students/:id/signups/add' do
  if find_student(params[:id])
    new_signup = Signup.new(params[:inscripcion])

    if new_signup.save
      flash[:notice] = 'Inscripción generada exitosamente.'
      redirect "/dashboard/students/#{params[:id]}/signups"
    else
      flash[:error] = new_signup.errors.full_messages
      redirect "/dashboard/students/#{params[:id]}/signups/add"
    end
  end
end

get '/dashboard/students/:idE/signups/:idS/delete' do
  if find_student(params[:idE]) && find_signup(params[:idE], params[:idS])
    titulo('Eliminar inscripción')
    @id_estudiante = params[:idE]
    @id_inscripcion = params[:idS]
    @query = Signup.find(params[:idS])
    erb :delete_signup, layout: :'layouts/dashboard'
  end
end

delete '/:idE/delete_signup/:idS' do
  if Signup.destroy(params[:idS])
    flash[:notice] = 'Inscripción eliminada.'
    redirect "/dashboard/students/#{params[:idE]}/signups"
  else
    flash[:error] = 'Ha ocurrido un error, intente nuevamente.'
    redirect "/dashboard/students/#{params[:idE]}/signups/#{params[:idS]}/delete"
  end
end

get '/dashboard/students/:idE/signups/:idS/edit' do
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
  edit_signup = Signup.find(params[:idS])
  edit_signup.update(params[:inscripcion])
  if edit_signup.save
    flash[:notice] = 'Datos actualizados.'
    redirect "/dashboard/students/#{params[:idE]}/signups"
  else
    flash[:error] = edit_signup.errors.full_messages
    redirect "/dashboard/students/#{params[:idE]}/signups/#{params[:idS]}/edit"
  end
end
