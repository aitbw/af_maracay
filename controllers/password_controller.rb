def change_password
  u = Usuario.find(session[:id])

  new_password = BCrypt::Password.create(params[:password])

  u.passwordUsuario = new_password

  if u.save
    redirect '/dashboard/change_password', notice: 'Cambio de contraseña exitoso.'
  else
    redirect '/dashboard/change_password', error: 'Ha ocurrido un error, intente nuevamente.'
  end
end

def reset_password
  u = Usuario.find(params[:id])

  new_password = BCrypt::Password.create(params[:password])

  u.passwordUsuario = new_password

  if u.save
    redirect '/dashboard/users', notice: 'Contraseña reestablecida exitosamente.'
  else
    redirect "/dashboard/users/reset_password/#{params[:id]}", error: 'Ha ocurrido un error, intente nuevamente.'
  end
end
