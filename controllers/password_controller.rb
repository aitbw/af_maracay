def change_password
  user = Usuario.find(session[:id])
  user.passwordUsuario = params[:password]

  if user.save
    flash[:notice] = 'Cambio de contraseña exitoso.'
  else
    flash[:error] = 'Ha ocurrido un error, intente nuevamente.'
  end
  redirect '/dashboard/change_password'
end

def reset_password
  user = Usuario.find(params[:id])
  user.passwordUsuario = params[:password]

  if user.save
    flash[:notice] = 'Contraseña reestablecida exitosamente.'
    redirect '/dashboard/users'
  else
    flash[:error] = 'Ha ocurrido un error, intente nuevamente.'
    redirect "/dashboard/users/#{params[:id]}/reset_password"
  end
end
