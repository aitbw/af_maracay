# app.rb

require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'
require 'sinatra/redirect_with_flash'
require 'tilt/erubis'
require 'bcrypt'
require './environments'
Dir['./controllers/*.rb'].each { |file| require file }
Dir['./models/*.rb'].each { |file| require file }

enable :sessions
set :session_secret, SecureRandom.hex(64)

def titulo(title)
  @page_title = title
end

before '/signin' do
  redirect '/dashboard' if session[:cedula]
end

get '/signin' do
  titulo('Iniciar sesión')
  erb :signin, layout: :'layouts/login'
end

post '/signin' do
  if params[:cedula].blank? || params[:password].blank?
    redirect '/signin', error: 'Debe completar todos los campos.'
  else
    authenticate(params[:cedula], params[:password])
  end
end

check_session

get '/dashboard' do
  titulo('Panel de control — Inicio')
  erb :index, layout: :'layouts/dashboard'
end

get '/logout' do
  session.clear
  redirect '/signin', notice: 'Usted ha cerrado sesión.'
end

restrict_access

get '/dashboard/users/new_user' do
  titulo('Crear nuevo usuario — Panel de control')
  erb :new_user, layout: :'layouts/dashboard'
end

post '/dashboard/users/new_user' do
  secure_pass = BCrypt::Password.create(params[:password])

  @usuarios = User.new(nombreUsuario: params[:nombre], cedulaUsuario: params[:cedula], passwordUsuario: secure_pass, nivelAcceso: params[:rol])

  if @usuarios.save
    redirect '/dashboard/users/new_user', notice: 'Usuario creado exitosamente.'
  else
    redirect '/dashboard/users/new_user', error: 'Ha ocurrido un error, intente nuevamente.'
  end
end

get '/dashboard/users' do
  titulo('Lista de usuarios — Panel de control')
  @users = User.all
  erb :users, layout: :'layouts/dashboard'
end

get '/dashboard/users/delete/:id' do
  begin
    User.find(params[:id]).present?
  rescue ActiveRecord::RecordNotFound
    redirect '/dashboard/users', error: 'El usuario no existe.'
  else
    @id_usuario = params[:id]
    @nombre = User.where(idUsuario: params[:id]).pluck(:nombreUsuario).to_s.gsub(/^\["|\"\]$/, '')
    titulo('Eliminar usuario — Panel de control')
    erb :delete_user, layout: :'layouts/dashboard'
  end
end

delete '/delete_user/:id' do
  if User.destroy(params[:id])
    redirect '/dashboard/users', notice: 'Usuario eliminado.'
  else
    redirect '/dashboard/users', error: 'Ha ocurrido un error, intente nuevamente.'
  end
end

get '/dashboard/users/edit/:id' do
  begin
    User.find(params[:id]).present?
  rescue ActiveRecord::RecordNotFound
    redirect '/dashboard/users', error: 'El usuario no existe.'
  else
    @id_usuario = params[:id]
    titulo('Editar usuario — Panel de control')
    erb :edit_user, layout: :'layouts/dashboard'
  end
end

put '/edit_user/:id' do
  u = User.find(params[:id])

  u.nombreUsuario = params[:nombre] if params[:nombre].blank? == false

  if params[:cedula].blank?
    u.cedulaUsuario = u.cedulaUsuario
  elsif /\d{6,8}/.match(params[:cedula]).nil?
    redirect '/dashboard/users', error: 'Cédula inválida.'
  elsif User.where(cedulaUsuario: params[:cedula]).present?
    redirect '/dashboard/users', error: 'La cédula ya existe.'
  else
    u.cedulaUsuario = params[:cedula]
  end

  if params[:rol] == 'empty'
    u.nivelAcceso = u.nivelAcceso
  else
    u.nivelAcceso = params[:rol]
  end

  if u.save
    redirect '/dashboard/users', notice: 'Datos actualizados.'
  else
    redirect '/dashboard/users', error: 'Ha ocurrido un error, intente nuevamente.'
  end
end

get '/dashboard/change_password' do
  titulo('Cambiar contraseña — Panel de control')
  @id_usuario = User.where(cedulaUsuario: session[:cedula]).pluck(:idUsuario).to_s.gsub(/\W/, '')
  erb :change_password, layout: :'layouts/dashboard'
end

put '/change_password/:id' do
  change_password
end

get '/dashboard/teachers' do
  titulo('Lista de profesores — Panel de control')
  @teachers = Teacher.all
  erb :teachers, layout: :'layouts/dashboard'
end

get '/dashboard/teachers/new_teacher' do
  titulo('Registrar nuevo profesor — Panel de control')
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
    @nombre = Teacher.where(idProfesor: params[:id]).pluck(:nombreProfesor).to_s.gsub(/^\["|\"\]$/, '')
    titulo('Eliminar profesor — Panel de control')
    erb :delete_teacher, layout: :'layouts/dashboard'
  end
end

delete '/delete_teacher/:id' do
  if Teacher.destroy(params[:id])
    redirect '/dashboard/teachers', notice: 'Profesor eliminado.'
  else
    redirect '/dashboard/teachers', error: 'Ha ocurrido un error, intente nuevamente.'
  end
end

get '/dashboard/teachers/edit/:id' do
  begin
    Teacher.find(params[:id]).present?
  rescue ActiveRecord::RecordNotFound
    redirect '/dashboard/teachers', error: 'El profesor no existe.'
  else
    @id_profesor = params[:id]
    titulo('Editar profesor — Panel de control')
    erb :edit_teacher, layout: :'layouts/dashboard'
  end
end

put '/edit_teacher/:id' do
  t = Teacher.find(params[:id])
  EMAIL_REGEX ||= /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  t.nombreProfesor = params[:nombre] if params[:nombre].blank? == false

  if params[:correo].blank?
    t.correoProfesor = t.correoProfesor
  elsif EMAIL_REGEX.match(params[:correo]).nil?
    redirect '/dashboard/teachers', error: 'Correo inválido.'
  elsif Teacher.where(correoProfesor: params[:correo]).present?
    redirect '/dashboard/teachers', error: 'El correo ya existe.'
  else
    t.correoProfesor = params[:correo]
  end

  if params[:telefono].blank?
    t.telefonoProfesor = t.telefonoProfesor
  elsif /\d{4}-?\d{7}/.match(params[:telefono]).nil?
    redirect '/dashboard/teachers', error: 'Número inválido.'
  else
    t.telefonoProfesor = params[:telefono]
  end

  if params[:cedula].blank?
    t.cedulaProfesor = t.cedulaProfesor
  elsif /\d{6,8}/.match(params[:cedula]).nil?
    redirect '/dashboard/teachers', error: 'Cédula inválida.'
  elsif Teacher.where(cedulaProfesor: params[:cedula]).present?
    redirect '/dashboard/teachers', error: 'La cédula ya existe.'
  else
    t.cedulaProfesor = params[:cedula]
  end

  if t.save
    redirect '/dashboard/teachers', notice: 'Datos actualizados.'
  else
    redirect '/dashboard/teachers', error: 'Ha ocurrido un error, intente nuevamente.'
  end
end

get '/dashboard/teachers/add_bank_account' do
  titulo('Asignar cuenta bancaria — Panel de control')
  @teachers = Teacher.select(:idProfesor, :nombreProfesor)
  @banks = Bank.all
  erb :add_bank_account, layout: :'layouts/dashboard'
end

post '/dashboard/teachers/add_bank_account' do
  asignar_cuenta
end

not_found do
  # TO-DO: 404 erb(:not_found)
  status 404
end

after do
  ActiveRecord::Base.connection.close
end
