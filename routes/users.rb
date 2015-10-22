# Helper to keep exception handling DRY
def find_user(id)
  Usuario.find(id).present?
rescue ActiveRecord::RecordNotFound
  redirect '/dashboard/users', error: 'El usuario no existe.'
end

before %r{\/(delete|edit)_user\/(\d)} do |_action, id|
  find_user(id)
end

before '/reset_password/:id' do
  find_user(params[:id])
end

before '/change_password' do
  begin
    Usuario.find(session[:id]).present?
  rescue ActiveRecord::RecordNotFound
    session.clear
    redirect '/signin', error: 'El usuario no existe.'
  end
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
    flash[:error] = new_user.errors.full_messages
    redirect '/dashboard/users/new_user'
  end
end

get '/dashboard/users/:id/delete' do
  if find_user(params[:id])
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
    flash[:error] = 'Ha ocurrido un error, intente nuevamente.'
    redirect "/dashboard/users/#{params[:id]}/delete"
  end
end

get '/dashboard/users/:id/edit' do
  if find_user(params[:id])
    @id_usuario = params[:id]
    @query = Usuario.find(params[:id])
    titulo('Editar usuario')
    erb :edit_user, layout: :'layouts/dashboard'
  end
end

put '/edit_user/:id' do
  edit_user = Usuario.find(params[:id])
  edit_user.update(params[:usuario])
  if edit_user.save
    redirect '/dashboard/users', notice: 'Datos actualizados.'
  else
    flash[:error] = edit_user.errors.full_messages
    redirect "/dashboard/users/#{params[:id]}/edit"
  end
end

get '/dashboard/change_password' do
  titulo('Cambiar contraseña')
  erb :change_password, layout: :'layouts/dashboard'
end

put '/change_password' do
  if (params[:password] || params[:confirm]).blank?
    flash[:error] = 'Debe completar todos los campos.'
  elsif params[:password] != params[:confirm]
    flash[:error] = 'Los campos no coinciden.'
  else
    change_password
  end
  redirect '/dashboard/change_password'
end

get '/dashboard/users/:id/reset_password' do
  if find_user(params[:id])
    titulo('Reestablecer contraseña')
    @id_usuario = params[:id]
    erb :reset_password, layout: :'layouts/dashboard'
  end
end

put '/reset_password/:id' do
  if (params[:password] || params[:confirm]).blank?
    flash[:error] = 'Debe completar todos los campos.'
  elsif params[:password] != params[:confirm]
    flash[:error] = 'Los campos no coinciden.'
  else
    reset_password
  end
  redirect "/dashboard/users/#{params[:id]}/reset_password"
end
