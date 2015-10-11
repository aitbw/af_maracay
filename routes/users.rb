# Helper to keep exception handling DRY
def find_user(id)
  Usuario.find(id).present?
rescue ActiveRecord::RecordNotFound
  redirect '/dashboard/users', error: 'El usuario no existe.'
end

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

  if new_user.save
    redirect '/dashboard/users', notice: 'Usuario creado exitosamente.'
  else
    redirect '/dashboard/users/new_user', flash[:error] = new_user.errors.full_messages
  end
end

get '/dashboard/users/delete/:id' do
  if find_user(params[:id])
    @id_usuario = params[:id]
    @query = Usuario.find(params[:id])
    titulo('Eliminar usuario')
    erb :delete_user, layout: :'layouts/dashboard'
  end
end

delete '/delete_user/:id' do
  if find_user(params[:id])
    Usuario.destroy(params[:id])
    redirect '/dashboard/users', notice: 'Usuario eliminado.'
  else
    redirect "/dashboard/users/delete/#{params[:id]}", error: 'Ha ocurrido un error, intente nuevamente.'
  end
end

get '/dashboard/users/edit/:id' do
  if find_user(params[:id])
    @id_usuario = params[:id]
    @query = Usuario.find(params[:id])
    titulo('Editar usuario')
    erb :edit_user, layout: :'layouts/dashboard'
  end
end

put '/edit_user/:id' do
  if find_user(params[:id])
    edit_user = Usuario.find(params[:id])
    edit_user.update(params[:usuario])
    redirect '/dashboard/users', notice: 'Datos actualizados.' if edit_user.save
  else
    redirect "/dashboard/users/edit/#{params[:id]}", flash[:error] = edit_user.errors.full_messages
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
  if find_user(params[:id])
    titulo('Reestablecer contraseña')
    @id_usuario = params[:id]
    erb :reset_password, layout: :'layouts/dashboard'
  end
end

before '/reset_password/:id' do
  find_user(params[:id])
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
