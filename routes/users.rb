get '/dashboard/users' do
  set_page_title('Usuarios')
  @users = User.search_user(params[:cedula]).paginate(page: params[:page])
  erb :users, user_layout
end

get '/dashboard/users/new_user' do
  set_page_title('Crear nuevo usuario')
  erb :'new/new_user', user_layout
end

post '/dashboard/users/new_user' do
  new_user = User.new(params[:user])

  if new_user.save
    redirect '/dashboard/users', notice: 'Usuario creado exitosamente.'
  else
    flash[:errors] = new_user.errors.full_messages
    redirect "#{request.path_info}"
  end
end

get '/dashboard/users/:id/delete' do
  @user = User.find(params[:id])
  set_page_title('Eliminar usuario')
  erb :'delete/delete_user', user_layout
end

delete '/dashboard/users/:id/delete' do
  if User.destroy(params[:id])
    redirect '/dashboard/users', notice: 'Usuario eliminado.'
  else
    flash[:error] = 'Ha ocurrido un error, intente nuevamente.'
    redirect "#{request.path_info}"
  end
end

get '/dashboard/users/:id/edit' do
  @user = User.find(params[:id])
  set_page_title('Editar usuario')
  erb :'edit/edit_user', user_layout
end

put '/dashboard/users/:id/edit' do
  edit_user = User.find(params[:id])
  if edit_user.update(params[:user])
    redirect '/dashboard/users', notice: 'Datos actualizados.'
  else
    flash[:errors] = edit_user.errors.full_messages
    redirect "#{request.path_info}"
  end
end

get '/dashboard/change_password' do
  set_page_title('Cambiar contraseña')
  erb :change_password, user_layout
end

put '/dashboard/change_password' do
  if (params[:password] || params[:confirm]).blank?
    flash[:error] = 'Debe completar todos los campos.'
  elsif params[:password] != params[:confirm]
    flash[:error] = 'Los campos no coinciden.'
  else
    change_password
  end
  redirect "#{request.path_info}"
end

get '/dashboard/users/:id/reset_password' do
  set_page_title('Reestablecer contraseña')
  @user_id = params[:id]
  erb :reset_password, user_layout
end

put '/dashboard/users/:id/reset_password' do
  if (params[:password] || params[:confirm]).blank?
    flash[:error] = 'Debe completar todos los campos.'
  elsif params[:password] != params[:confirm]
    flash[:error] = 'Los campos no coinciden.'
  else
    reset_password
  end
  redirect "#{request.path_info}"
end

get '/dashboard/users/:id/lock_account' do
  @user = User.find(params[:id])

  if @user.update(has_access: false)
    flash[:notice] = 'Cuenta bloqueada.'
  else
    flash[:error] = 'Ha ocurrido un error, intente nuevamente.'
  end
  redirect '/dashboard/users'
end

get '/dashboard/users/:id/unlock_account' do
  @user = User.find(params[:id])

  if @user.update(has_access: true)
    flash[:notice] = 'Cuenta desbloqueada.'
  else
    flash[:error] = 'Ha ocurrido un error, intente nuevamente.'
  end
  redirect '/dashboard/users'
end
