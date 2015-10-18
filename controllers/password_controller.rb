def change_password
  user = Usuario.find(session[:id])
rescue ActiveRecord::RecordNotFound
  session.clear
  redirect '/signin', error: 'El usuario no existe.'
else
  new_password = BCrypt::Password.create(params[:password])
  user.passwordUsuario = new_password

  if user.save
    redirect '/dashboard/change_password', notice: 'Cambio de contraseña exitoso.'
  else
    redirect '/dashboard/change_password', error: 'Ha ocurrido un error, intente nuevamente.'
  end
end

def reset_password
  user = Usuario.find(params[:id])
  new_password = BCrypt::Password.create(params[:password])
  user.passwordUsuario = new_password

  if user.save
    redirect '/dashboard/users', notice: 'Contraseña reestablecida exitosamente.'
  else
    redirect "/dashboard/users/#{params[:id]}/reset_password", error: 'Ha ocurrido un error, intente nuevamente.'
  end
end
