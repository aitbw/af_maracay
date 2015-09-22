def authenticate(cedula, password)
  if Usuario.where(cedulaUsuario: cedula).present?

    query = Usuario.find_by(cedulaUsuario: cedula)
    @user_hash = BCrypt::Password.new(query.passwordUsuario)

    if @user_hash == password
      session[:cedula] = cedula
      session[:nombre] = query.nombreUsuario
      session[:rol] = query.nivelAcceso
      redirect '/dashboard'
    else
      redirect '/signin', error: 'Datos incorrectos, intente nuevamente.'
    end
  else
    redirect '/signin', error: 'El usuario no existe.'
  end
end
