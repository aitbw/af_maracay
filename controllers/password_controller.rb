def change_password
  if (params[:password] || params[:confirm]).blank?
    redirect '/dashboard/change_password', error: 'Debe completar todos los campos.'
  elsif params[:password] != params[:confirm]
    redirect '/dashboard/change_password', error: 'Los campos no coinciden.'
  else
    u = Usuario.find_by(cedulaUsuario: session[:cedula])

    new_password = BCrypt::Password.create(params[:password])

    u.passwordUsuario = new_password

    if u.save
      redirect '/dashboard/change_password', notice: 'Cambio de contraseña exitoso.'
    else
      redirect '/dashboard/change_password', error: 'Ha ocurrido un error, intente nuevamente.'
    end
  end
end
