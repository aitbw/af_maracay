# app.rb

require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'
require 'sinatra/redirect_with_flash'
require 'tilt/erubis'
require 'bcrypt'
require './environments'
Dir['./controllers/*.rb', './models/*.rb'].each { |file| require file }

enable :sessions
set :session_secret, SecureRandom.hex(64)

def titulo(title)
  @page_title = title
end

get '/signin' do
  erb :signin
end

post '/signin' do
  if (params[:cedula] || params[:password]).blank?
    redirect '/signin', error: 'Debe completar todos los campos.'
  else
    authenticate(params[:cedula], params[:password])
  end
end

get '/dashboard' do
  titulo('Panel de control — Inicio')
  erb :index, layout: :'layouts/dashboard'
end

get '/logout' do
  session.clear
  redirect '/signin', notice: 'Usted ha cerrado sesión.'
end

get '/dashboard/users' do
  titulo('Lista de usuarios — Panel de control')
  @users = User.all
  erb :users, layout: :'layouts/dashboard'
end

get '/dashboard/users/new_user' do
  titulo('Crear nuevo usuario — Panel de control')
  erb :new_user, layout: :'layouts/dashboard'
end

post '/dashboard/users/new_user' do
  secure_pass = BCrypt::Password.create(params[:password])

  new_user = User.new(nombreUsuario: params[:nombre], cedulaUsuario: params[:cedula], passwordUsuario: secure_pass, nivelAcceso: params[:rol])

  if new_user.save
    redirect '/dashboard/users/new_user', notice: 'Usuario creado exitosamente.'
  else
    redirect '/dashboard/users/new_user', error: 'Ha ocurrido un error, intente nuevamente.'
  end
end

get '/dashboard/users/delete/:id' do
  begin
    User.find(params[:id]).present?
  rescue ActiveRecord::RecordNotFound
    redirect '/dashboard/users', error: 'El usuario no existe.'
  else
    @id_usuario = params[:id]
    @query = User.find(params[:id])
    titulo('Eliminar usuario — Panel de control')
    erb :delete_user, layout: :'layouts/dashboard'
  end
end

delete '/delete_user/:id' do
  if User.destroy(params[:id])
    redirect '/dashboard/users', notice: 'Usuario eliminado.'
  else
    redirect "/dashboard/users/delete/#{params[:id]}", error: 'Ha ocurrido un error, intente nuevamente.'
  end
end

get '/dashboard/users/edit/:id' do
  begin
    User.find(params[:id]).present?
  rescue ActiveRecord::RecordNotFound
    redirect '/dashboard/users', error: 'El usuario no existe.'
  else
    @id_usuario = params[:id]
    @user = User.find(params[:id])
    titulo('Editar usuario — Panel de control')
    erb :edit_user, layout: :'layouts/dashboard'
  end
end

put '/edit_user/:id' do
  u = User.find(params[:id])

  if params[:nombre].blank?
    redirect "/dashboard/users/edit/#{params[:id]}", error: 'Debe completar todos los campos.'
  end

  u.nombreUsuario = params[:nombre]
  u.nivelAcceso = params[:rol]

  if u.cedulaUsuario == params[:cedula]
    u.cedulaUsuario = u.cedulaUsuario
  elsif /\d{6,8}/.match(params[:cedula]).nil?
    redirect "/dashboard/users/edit/#{params[:id]}", error: 'Cédula inválida.'
  elsif User.where(cedulaUsuario: params[:cedula]).present?
    redirect "/dashboard/users/edit/#{params[:id]}", error: 'La cédula ya existe.'
  else
    u.cedulaUsuario = params[:cedula]
  end

  if u.save
    redirect '/dashboard/users', notice: 'Datos actualizados.'
  else
    redirect "/dashboard/users/edit/#{params[:id]}", error: 'Ha ocurrido un error, intente nuevamente.'
  end
end

get '/dashboard/change_password' do
  titulo('Cambiar contraseña — Panel de control')
  erb :change_password, layout: :'layouts/dashboard'
end

put '/change_password' do
  change_password
end

get '/dashboard/teachers' do
  titulo('Lista de profesores — Panel de control')
  @teachers = Teacher.all
  erb :teachers, layout: :'layouts/dashboard'
end

get '/dashboard/teachers/new_teacher' do
  titulo('Crear nuevo profesor — Panel de control')
  erb :new_teacher, layout: :'layouts/dashboard'
end

post '/dashboard/teachers/new_teacher' do
  nuevo_profesor
end

get '/dashboard/teachers/delete/:id' do
  begin
    Teacher.find(params[:id]).present?
  rescue ActiveRecord::RecordNotFound
    redirect '/dashboard/teachers', error: 'El profesor no existe.'
  else
    @id_profesor = params[:id]
    @query = Teacher.find(params[:id])
    titulo('Eliminar profesor — Panel de control')
    erb :delete_teacher, layout: :'layouts/dashboard'
  end
end

delete '/delete_teacher/:id' do
  if Teacher.destroy(params[:id])
    redirect '/dashboard/teachers', notice: 'Profesor eliminado.'
  else
    redirect "/dashboard/teachers/delete/#{params[:id]}", error: 'Ha ocurrido un error, intente nuevamente.'
  end
end

get '/dashboard/teachers/edit/:id' do
  begin
    Teacher.find(params[:id]).present?
  rescue ActiveRecord::RecordNotFound
    redirect '/dashboard/teachers', error: 'El profesor no existe.'
  else
    @id_profesor = params[:id]
    @teacher = Teacher.find(params[:id])
    titulo('Editar profesor — Panel de control')
    erb :edit_teacher, layout: :'layouts/dashboard'
  end
end

put '/edit_teacher/:id' do
  t = Teacher.find(params[:id])
  EMAIL_REGEX ||= /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  if params[:nombre].blank?
    redirect "/dashboard/teachers/edit/#{params[:id]}", error: 'Debe completar todos los campos.'
  end

  t.nombreProfesor = params[:nombre]

  if t.correoProfesor == params[:correo]
    t.correoProfesor = t.correoProfesor
  elsif EMAIL_REGEX.match(params[:correo]).nil?
    redirect "/dashboard/teachers/edit/#{params[:id]}", error: 'Correo inválido.'
  elsif Teacher.where(correoProfesor: params[:correo]).present?
    redirect "/dashboard/teachers/edit/#{params[:id]}", error: 'El correo ya existe.'
  else
    t.correoProfesor = params[:correo]
  end

  if /\d{4}-?\d{7}/.match(params[:telefono]).nil?
    redirect "/dashboard/teachers/edit/#{params[:id]}", error: 'Número inválido.'
  else
    t.telefonoProfesor = params[:telefono]
  end

  if t.cedulaProfesor == params[:cedula]
    t.cedulaProfesor = t.cedulaProfesor
  elsif /\d{6,8}/.match(params[:cedula]).nil?
    redirect "/dashboard/teachers/edit/#{params[:id]}", error: 'Cédula inválida.'
  elsif Teacher.where(cedulaProfesor: params[:cedula]).present?
    redirect "/dashboard/teachers/edit/#{params[:id]}", error: 'La cédula ya existe.'
  else
    t.cedulaProfesor = params[:cedula]
  end

  if t.save
    redirect '/dashboard/teachers', notice: 'Datos actualizados.'
  else
    redirect "/dashboard/teachers/edit/#{params[:id]}", error: 'Ha ocurrido un error, intente nuevamente.'
  end
end

get '/dashboard/teachers/bank_accounts/:id' do
  begin
    Teacher.find(params[:id]).present?
  rescue ActiveRecord::RecordNotFound
    redirect '/dashboard/teachers', error: 'El profesor no existe.'
  else
    titulo('Cuentas bancarias — Panel de control')
    @id_profesor = params[:id]
    @accounts = Account.where(idProfesor: params[:id])
    erb :bank_accounts, layout: :'layouts/dashboard'
  end
end

get '/dashboard/teachers/bank_accounts/:id/add' do
  begin
    Teacher.find(params[:id]).present?
  rescue ActiveRecord::RecordNotFound
    redirect '/dashboard/teachers', error: 'El profesor no existe.'
  else
    titulo('Asignar cuenta bancaria — Panel de control')
    @id_profesor = params[:id]
    @banks = Bank.all
    erb :add_bank_account, layout: :'layouts/dashboard'
  end
end

post '/dashboard/teachers/bank_accounts/:id/add' do
  asignar_cuenta
end

get '/dashboard/teachers/bank_accounts/:idT/delete/:idC' do
  begin
    (Teacher.find(params[:idT]) || Account.find(params[:idC])).present?
  rescue ActiveRecord::RecordNotFound
    redirect '/dashboard/teachers', error: 'El profesor o la cuenta bancaria asociada no existen.'
  else
    titulo('Eliminar cuenta bancaria — Panel de control')
    @id_profesor = params[:idT]
    @id_cuenta = params[:idC]
    @cuenta = Account.find(params[:idC])
    erb :delete_bank_account, layout: :'layouts/dashboard'
  end
end

delete '/:idT/delete_bank_account/:idC' do
  if Account.destroy(params[:idC])
    redirect "/dashboard/teachers/bank_accounts/#{params[:idT]}", notice: 'Cuenta bancaria eliminada.'
  else
    redirect "/dashboard/teachers/bank_accounts/#{params[:idT]}/delete/#{params[:idC]}", error: 'Ha ocurrido un error, intente nuevamente.'
  end
end

get '/dashboard/teachers/bank_accounts/:idT/edit/:idC' do
  begin
    (Teacher.find(params[:idT]) || Account.find(params[:idC])).present?
  rescue ActiveRecord::RecordNotFound
    redirect '/dashboard/teachers', error: 'El profesor o la cuenta bancaria asociada no existen.'
  else
    titulo('Editar cuenta bancaria — Panel de control')
    @id_profesor = params[:idT]
    @id_cuenta = params[:idC]
    @cuenta = Account.find(params[:idC])
    @bank = Bank.all
    erb :edit_bank_account, layout: :'layouts/dashboard'
  end
end

put '/:idT/edit_bank_account/:idC' do
  c = Account.find(params[:idC])

  c.tipoCuenta = params[:tipo]
  c.idBanco = params[:banco]

  if /\d{20}/.match(params[:numero]).nil?
    redirect "/dashboard/teachers/bank_accounts/#{params[:idT]}/edit/#{params[:idC]}", error: 'Número de cuenta inválido.'
  else
    c.numeroCuenta = params[:numero]
  end

  if c.save
    redirect "/dashboard/teachers/bank_accounts/#{params[:idT]}", notice: 'Datos actualizados.'
  else
    redirect "/dashboard/teachers/bank_accounts/#{params[:idT]}/edit/#{params[:idC]}", error: 'Ha ocurrido un error, intente nuevamente.'
  end
end

get '/dashboard/courses' do
  titulo('Cursos — Panel de control')
  @courses = Course.all
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
  c = Course.find(params[:id])

  if (params[:nivel] || params[:capacidad] || params[:inicio] || params[:fin] || params[:horas]).blank?
    redirect "/dashboard/courses/edit/#{params[:id]}", error: 'Debe completar todos los campos.'
  end

  c.idTipoCurso = params[:tipo]
  c.nivelCurso = params[:nivel]
  c.capacidadCurso = params[:capacidad]
  c.inicioCurso = params[:inicio]
  c.finCurso = params[:fin]
  c.horasCurso = params[:horas]

  if c.save
    redirect '/dashboard/courses', notice: 'Datos actualizados.'
  else
    redirect "/dashboard/courses/edit/#{params[:id]}", error: 'Ha ocurrido un error, intente nuevamente.'
  end
end

not_found do
  # TO-DO: 404 erb(:not_found)
  status 404
end

after do
  ActiveRecord::Base.connection.close
end
