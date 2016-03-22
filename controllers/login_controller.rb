def authenticate(cedula, password)
  user = User.find_by(user_cedula: cedula)
  @user_hash = BCrypt::Password.new(user.user_password)

  if @user_hash == password
    session[:id] = user.user_id
    session[:name] = user.user_name
    session[:role] = user.access_level
    redirect '/dashboard'
  else
    redirect '/signin', error: 'Datos incorrectos, intente nuevamente.'
  end
end

def user_exists?(cedula)
  if User.where(user_cedula: cedula).present?
    authenticate(params[:cedula], params[:password])
  else
    redirect '/signin', error: 'El usuario no existe.'
  end
end
