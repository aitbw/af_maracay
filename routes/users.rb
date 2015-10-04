get '/dashboard/users' do
  titulo('Usuarios')
  @users = Usuario.all
  erb :users, layout: :'layouts/dashboard'
end

get '/dashboard/users/new_user' do
  titulo('Crear nuevo usuario')
  erb :new_user, layout: :'layouts/dashboard'
end

post '/dashboard/users/new_user' do
  new_user = Usuario.new(params[:usuario])

  if new_user.valid?
    secure_pass = BCrypt::Password.create(params[:usuario][:passwordUsuario])
    new_user.update(passwordUsuario: secure_pass)
  end

  if new_user.save
    redirect '/dashboard/users', notice: 'Usuario creado exitosamente.'
  else
    redirect '/dashboard/users/new_user', flash[:error] = new_user.errors.full_messages
  end
end

get '/dashboard/users/delete/:id' do
  begin
    Usuario.find(params[:id]).present?
  rescue ActiveRecord::RecordNotFound
    redirect '/dashboard/users', error: 'El usuario no existe.'
  else
    @id_usuario = params[:id]
    @query = Usuario.find(params[:id])
    titulo('Eliminar usuario')
    erb :delete_user, layout: :'layouts/dashboard'
  end
end

delete '/delete_user/:id' do
  if Usuario.destroy(params[:id])
    redirect '/dashboard/users', notice: 'Usuario eliminado.'
  else
    redirect "/dashboard/users/delete/#{params[:id]}", error: 'Ha ocurrido un error, intente nuevamente.'
  end
end

get '/dashboard/users/edit/:id' do
  begin
    Usuario.find(params[:id]).present?
  rescue ActiveRecord::RecordNotFound
    redirect '/dashboard/users', error: 'El usuario no existe.'
  else
    @id_usuario = params[:id]
    @user = Usuario.find(params[:id])
    titulo('Editar usuario')
    erb :edit_user, layout: :'layouts/dashboard'
  end
end

put '/edit_user/:id' do
  u = Usuario.find(params[:id])

  u.update(params[:usuario])

  if u.save
    redirect '/dashboard/users', notice: 'Datos actualizados.'
  else
    redirect "/dashboard/users/edit/#{params[:id]}", flash[:error] = u.errors.full_messages
  end
end

get '/dashboard/change_password' do
  titulo('Cambiar contraseña')
  erb :change_password, layout: :'layouts/dashboard'
end

put '/change_password' do
  if (params[:password] || params[:confirm]).blank?
    redirect '/dashboard/change_password', error: 'Debe completar todos los campos.'
  elsif params[:password] != params[:confirm]
    redirect '/dashboard/change_password', error: 'Los campos no coinciden.'
  else
    change_password
  end
end

get '/dashboard/users/reset_password/:id' do
  begin
    Usuario.find(params[:id]).present?
  rescue ActiveRecord::RecordNotFound
    redirect '/dashboard/users', error: 'El usuario no existe.'
  else
    titulo('Reestablecer contraseña')
    @id_usuario = params[:id]
    erb :reset_password, layout: :'layouts/dashboard'
  end
end

put '/reset_password/:id' do
  if (params[:password] || params[:confirm]).blank?
    redirect "/dashboard/users/reset_password/#{params[:id]}", error: 'Debe completar todos los campos.'
  elsif params[:password] != params[:confirm]
    redirect "/dashboard/users/reset_password/#{params[:id]}", error: 'Los campos no coinciden.'
  else
    reset_password
  end
end
