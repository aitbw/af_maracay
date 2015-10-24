# Helpers to keep exception handling DRY
def find_teacher(id)
  Teacher.find(id).present?
rescue ActiveRecord::RecordNotFound
  redirect '/dashboard/teachers', error: 'El profesor no existe.'
end

def find_account(profesor, cuenta)
  Account.find(cuenta).present?
rescue ActiveRecord::RecordNotFound
  flash[:error] = 'La cuenta asociada no existe.'
  redirect "/dashboard/teachers/#{profesor}/bank_accounts"
end

before %r{\/(delete|edit)_teacher\/(\d)} do |_action, id|
  find_teacher(id)
end

before %r{\/(\d)\/(delete|edit)_bank_account\/(\d)} do |profesor, _action, cuenta|
  find_teacher(profesor) && find_account(profesor, cuenta)
end

get '/dashboard/teachers' do
  titulo('Profesores')
  @teachers = Teacher.all
  erb :teachers, layout: :'layouts/dashboard'
end

get '/dashboard/teachers/new_teacher' do
  titulo('Crear nuevo profesor')
  @js = ['moment.min.js', 'bootstrap-datetimepicker.min.js']
  erb :new_teacher, layout: :'layouts/dashboard'
end

post '/dashboard/teachers/new_teacher' do
  nuevo_profesor
end

get '/dashboard/teachers/:id/delete' do
  if find_teacher(params[:id])
    @id_profesor = params[:id]
    @query = Teacher.find(params[:id])
    titulo('Eliminar profesor')
    erb :delete_teacher, layout: :'layouts/dashboard'
  end
end

delete '/delete_teacher/:id' do
  if Teacher.destroy(params[:id])
    redirect '/dashboard/teachers', notice: 'Profesor eliminado.'
  else
    flash[:error] = 'Ha ocurrido un error, intente nuevamente.'
    redirect "/dashboard/teachers/#{params[:id]}/delete"
  end
end

get '/dashboard/teachers/:id/edit' do
  if find_teacher(params[:id])
    @id_profesor = params[:id]
    @query = Teacher.find(params[:id])
    titulo('Editar profesor')
    erb :edit_teacher, layout: :'layouts/dashboard'
  end
end

put '/edit_teacher/:id' do
  edit_teacher = Teacher.find(params[:id])
  edit_teacher.update(params[:profesor])
  if edit_teacher.save
    redirect '/dashboard/teachers', notice: 'Datos actualizados.'
  else
    flash[:errors] = edit_teacher.errors.full_messages
    redirect "/dashboard/teachers/#{params[:id]}/edit"
  end
end

get '/dashboard/teachers/:id/bank_accounts' do
  if find_teacher(params[:id])
    titulo('Cuentas bancarias')
    @id_profesor = params[:id]
    @accounts = Account.where(idProfesor: params[:id])
    erb :bank_accounts, layout: :'layouts/dashboard'
  end
end

get '/dashboard/teachers/:id/bank_accounts/add' do
  if find_teacher(params[:id])
    titulo('Asignar cuenta bancaria')
    @id_profesor = params[:id]
    @banks = Banco.all
    erb :add_bank_account, layout: :'layouts/dashboard'
  end
end

post '/dashboard/teachers/:id/bank_accounts/add' do
  asignar_cuenta if find_teacher(params[:id])
end

get '/dashboard/teachers/:idT/bank_accounts/:idC/delete' do
  if find_teacher(params[:idT]) && find_account(params[:idT], params[:idC])
    titulo('Eliminar cuenta bancaria')
    @id_profesor = params[:idT]
    @id_cuenta = params[:idC]
    @query = Account.find(params[:idC])
    erb :delete_bank_account, layout: :'layouts/dashboard'
  end
end

delete '/:idT/delete_bank_account/:idC' do
  if Account.destroy(params[:idC])
    flash[:notice] = 'Cuenta bancaria eliminada.'
    redirect "/dashboard/teachers/#{params[:idT]}/bank_accounts"
  else
    flash[:error] = 'Ha ocurrido un error, intente nuevamente.'
    redirect "/dashboard/teachers/#{params[:idT]}/bank_accounts/#{params[:idC]}/delete"
  end
end

get '/dashboard/teachers/:idT/bank_accounts/:idC/edit' do
  if find_teacher(params[:idT]) && find_account(params[:idT], params[:idC])
    titulo('Editar cuenta bancaria')
    @id_profesor = params[:idT]
    @id_cuenta = params[:idC]
    @query = Account.find(params[:idC])
    @banks = Banco.all
    erb :edit_bank_account, layout: :'layouts/dashboard'
  end
end

put '/:idT/edit_bank_account/:idC' do
  edit_account = Account.find(params[:idC])
  edit_account.update(params[:cuenta])
  if edit_account.save
    flash[:notice] = 'Datos actualizados.'
    redirect "/dashboard/teachers/#{params[:idT]}/bank_accounts"
  else
    flash[:errors] = edit_account.errors.full_messages
    redirect "/dashboard/teachers/#{params[:idT]}/bank_accounts/#{params[:idC]}/edit"
  end
end
