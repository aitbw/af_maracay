def authenticate(cedula, password)
  if User.where(user_cedula: cedula).present?

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
  else
    redirect '/signin', error: 'El usuario no existe.'
  end
end
