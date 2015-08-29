# app.rb

require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'
require 'sinatra/redirect_with_flash'
require 'tilt/erubis'
require 'bcrypt'
require './environments'
Dir['./controllers/*.rb'].each { |file| require file }

enable :sessions
set :session_secret, SecureRandom.hex(64)

# Modelo para la tabla 'Usuarios'
class User < ActiveRecord::Base
  self.table_name = 'usuarios'
end

def titulo(title)
  @page_title = title
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
  if params[:nombre].blank? || params[:cedula].blank? || params[:password].blank?
    redirect '/dashboard/signup', error: 'Debe completar todos los campos.'
  elsif /^\d{6,8}$/.match(params[:cedula]).nil?
    redirect '/dashboard/signup', error: 'Cédula inválida, intente nuevamente.'
  elsif User.where(cedulaUsuario: params[:cedula]).present?
    redirect '/dashboard/signup', error: 'La cédula ya se encuentra en uso.'
  else
    secure_pass = BCrypt::Password.create(params[:password])

    @usuarios = User.new(nombreUsuario: params[:nombre], cedulaUsuario: params[:cedula], passwordUsuario: secure_pass, nivelAcceso: params[:rol])

    if @usuarios.save
      redirect '/dashboard/signup', notice: 'Usuario creado exitosamente.'
    else
      redirect '/dashboard/signup', error: 'Ha ocurrido un error, intente nuevamente.'
    end
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
  elsif /^\d{6,8}$/.match(params[:cedula]).nil?
    redirect '/dashboard/users', error: 'Cédula inválida, intente nuevamente.'
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

not_found do
  status 404
end

after do
  ActiveRecord::Base.connection.close
end
