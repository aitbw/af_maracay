def change_password
  user = Usuario.find(session[:id])
  new_password = BCrypt::Password.create(params[:password])
  user.passwordUsuario = new_password

  if user.save
    flash[:notice] = 'Cambio de contraseña exitoso.'
  else
    flash[:error] = 'Ha ocurrido un error, intente nuevamente.'
  end
  redirect '/dashboard/change_password'
end

def reset_password
  user = Usuario.find(params[:id])
  new_password = BCrypt::Password.create(params[:password])
  user.passwordUsuario = new_password

  if user.save
    flash[:notice] = 'Contraseña reestablecida exitosamente.'
    redirect '/dashboard/users'
  else
    flash[:error] = 'Ha ocurrido un error, intente nuevamente.'
    redirect "/dashboard/users/#{params[:id]}/reset_password"
  end
end
