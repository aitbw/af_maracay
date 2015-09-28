get '/dashboard/users' do
  titulo('Usuarios — Panel de control')
  @users = Usuario.all
  erb :users, layout: :'layouts/dashboard'
end

get '/dashboard/users/new_user' do
  titulo('Crear nuevo usuario — Panel de control')
  erb :new_user, layout: :'layouts/dashboard'
end

post '/dashboard/users/new_user' do
  secure_pass = BCrypt::Password.create(params[:password])

  new_user = Usuario.new(nombreUsuario: params[:nombre], cedulaUsuario: params[:cedula], passwordUsuario: secure_pass, nivelAcceso: params[:rol])

  if new_user.save
    redirect '/dashboard/users', notice: 'Usuario creado exitosamente.'
  else
    redirect '/dashboard/users/new_user', error: 'Ha ocurrido un error, intente nuevamente.'
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
    titulo('Eliminar usuario — Panel de control')
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
    titulo('Editar usuario — Panel de control')
    erb :edit_user, layout: :'layouts/dashboard'
  end
end

put '/edit_user/:id' do
  u = Usuario.find(params[:id])

  if params[:nombre].blank?
    redirect "/dashboard/users/edit/#{params[:id]}", error: 'Debe completar todos los campos.'
  end

  u.nombreUsuario = params[:nombre]
  u.nivelAcceso = params[:rol]

  if u.cedulaUsuario == params[:cedula]
    u.cedulaUsuario = u.cedulaUsuario
  elsif /\d{6,8}/.match(params[:cedula]).nil?
    redirect "/dashboard/users/edit/#{params[:id]}", error: 'Cédula inválida.'
  elsif Usuario.where(cedulaUsuario: params[:cedula]).present?
    redirect "/dashboard/users/edit/#{params[:id]}", error: 'La cédula ya existe.'
  else
    u.cedulaUsuario = params[:cedula]
  end

  if u.save
    redirect '/dashboard/users', notice: 'Datos actualizados.'
  else
    redirect "/dashboard/users/edit/#{params[:id]}", error: 'Ha ocurrido un error, intente nuevamente.'
  end
end

get '/dashboard/change_password' do
  titulo('Cambiar contraseña — Panel de control')
  erb :change_password, layout: :'layouts/dashboard'
end

put '/change_password' do
  change_password
end
