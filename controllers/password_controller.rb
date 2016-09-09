def change_password
  user = User.find(session[:id])
  user.user_password = BCrypt::Password.create(params[:password])

  if user.save
    flash[:notice] = 'Cambio de contraseña exitoso.'
  else
    flash[:error] = 'Ha ocurrido un error, intente nuevamente.'
  end
end

def reset_password
  user = User.find(params[:id])
  user.user_password = BCrypt::Password.create(params[:password])

  if user.save
    flash[:notice] = 'Contraseña reestablecida exitosamente.'
    redirect '/dashboard/users'
  else
    flash[:error] = 'Ha ocurrido un error, intente nuevamente.'
  end
end
