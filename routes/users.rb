# Helper to keep exception handling DRY
def find_user(id)
  User.find(id).present?
rescue ActiveRecord::RecordNotFound
  redirect '/dashboard/users', error: 'El usuario no existe.'
end

before %r{\/dashboard\/users\/(\d)\/(delete|edit)} do |id, _|
  find_user(id)
end

before '/dashboard/users/:id/reset_password' do
  find_user(params[:id])
end

before '/dashboard/change_password' do
  begin
    User.find(session[:id]).present?
  rescue ActiveRecord::RecordNotFound
    session.clear
    redirect '/signin', error: 'El usuario no existe.'
  end
end

get '/dashboard/users' do
  set_page_title('Usuarios')
  @users = User.all
  erb :users, layout: :'layouts/dashboard'
end

get '/dashboard/users/new_user' do
  set_page_title('Crear nuevo usuario')
  erb :new_user, layout: :'layouts/dashboard'
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
  if find_user(params[:id])
    @user = User.find(params[:id])
    set_page_title('Eliminar usuario')
    erb :delete_user, layout: :'layouts/dashboard'
  end
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
  if find_user(params[:id])
    @user = User.find(params[:id])
    set_page_title('Editar usuario')
    erb :edit_user, layout: :'layouts/dashboard'
  end
end

put '/dashboard/users/:id/edit' do
  edit_user = User.find(params[:id])
  edit_user.update(params[:user])
  if edit_user.save
    redirect '/dashboard/users', notice: 'Datos actualizados.'
  else
    flash[:errors] = edit_user.errors.full_messages
    redirect "#{request.path_info}"
  end
end

get '/dashboard/change_password' do
  set_page_title('Cambiar contraseña')
  erb :change_password, layout: :'layouts/dashboard'
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
  if find_user(params[:id])
    set_page_title('Reestablecer contraseña')
    @user_id = params[:id]
    erb :reset_password, layout: :'layouts/dashboard'
  end
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
