def authenticate(cedula, password)
  if User.where(cedulaUsuario: cedula).present?

    query = User.where(cedulaUsuario: cedula).pluck(:passwordUsuario).to_s.gsub(/^\["|\"\]$/, '')
    @user_hash = BCrypt::Password.new(query)

    if @user_hash == password
      session[:cedula] = cedula
      session[:nombre] = User.where(cedulaUsuario: session[:cedula]).pluck(:nombreUsuario).to_s.gsub(/^\["|\"\]$/, '')
      session[:rol] = User.where(cedulaUsuario: session[:cedula]).pluck(:nivelAcceso).to_s.gsub(/^\["|\"\]$/, '')
      redirect '/dashboard'
    else
      redirect '/signin', error: 'Datos incorrectos, intente nuevamente.'
    end
  else
    redirect '/signin', error: 'El usuario no existe.'
  end
end
