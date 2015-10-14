# Helpers to keep exception handling DRY
def find_teacher(id)
  Teacher.find(id).present?
rescue ActiveRecord::RecordNotFound
  redirect '/dashboard/teachers', error: 'El profesor no existe.'
end

def find_account(profesor, cuenta)
  Account.find(cuenta).present?
rescue ActiveRecord::RecordNotFound
  redirect "/dashboard/teachers/bank_accounts/#{profesor}", error: 'La cuenta asociada no existe.'
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

get '/dashboard/teachers/delete/:id' do
  if find_teacher(params[:id])
    @id_profesor = params[:id]
    @query = Teacher.find(params[:id])
    titulo('Eliminar profesor')
    erb :delete_teacher, layout: :'layouts/dashboard'
  end
end

delete '/delete_teacher/:id' do
  if find_teacher(params[:id])
    Teacher.destroy(params[:id])
    redirect '/dashboard/teachers', notice: 'Profesor eliminado.'
  else
    redirect "/dashboard/teachers/delete/#{params[:id]}", error: 'Ha ocurrido un error, intente nuevamente.'
  end
end

get '/dashboard/teachers/edit/:id' do
  if find_teacher(params[:id])
    @id_profesor = params[:id]
    @query = Teacher.find(params[:id])
    titulo('Editar profesor')
    erb :edit_teacher, layout: :'layouts/dashboard'
  end
end

put '/edit_teacher/:id' do
  if find_teacher(params[:id])
    edit_teacher = Teacher.find(params[:id])
    edit_teacher.update(params[:profesor])
    redirect '/dashboard/teachers', notice: 'Datos actualizados.' if edit_teacher.save
  else
    redirect "/dashboard/teachers/edit/#{params[:id]}", flash[:error] = edit_teacher.errors.full_messages
  end
end

get '/dashboard/teachers/bank_accounts/:id' do
  if find_teacher(params[:id])
    titulo('Cuentas bancarias')
    @id_profesor = params[:id]
    @accounts = Account.where(idProfesor: params[:id])
    erb :bank_accounts, layout: :'layouts/dashboard'
  end
end

get '/dashboard/teachers/bank_accounts/:id/add' do
  if find_teacher(params[:id])
    titulo('Asignar cuenta bancaria')
    @id_profesor = params[:id]
    @banks = Banco.all
    erb :add_bank_account, layout: :'layouts/dashboard'
  end
end

post '/dashboard/teachers/bank_accounts/:id/add' do
  asignar_cuenta if find_teacher(params[:id])
end

get '/dashboard/teachers/bank_accounts/:idT/delete/:idC' do
  if find_teacher(params[:idT]) && find_account(params[:idT], params[:idC])
    titulo('Eliminar cuenta bancaria')
    @id_profesor = params[:idT]
    @id_cuenta = params[:idC]
    @query = Account.find(params[:idC])
    erb :delete_bank_account, layout: :'layouts/dashboard'
  end
end

delete '/:idT/delete_bank_account/:idC' do
  if find_teacher(params[:idT]) && find_account(params[:idT], params[:idC])
    Account.destroy(params[:idC])
    redirect "/dashboard/teachers/bank_accounts/#{params[:idT]}", notice: 'Cuenta bancaria eliminada.'
  else
    redirect "/dashboard/teachers/bank_accounts/#{params[:idT]}/delete/#{params[:idC]}", error: 'Ha ocurrido un error, intente nuevamente.'
  end
end

get '/dashboard/teachers/bank_accounts/:idT/edit/:idC' do
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
  if find_teacher(params[:idT]) && find_account(params[:idT], params[:idC])
    edit_account = Account.find(params[:idC])
    edit_account.update(params[:cuenta])
    redirect "/dashboard/teachers/bank_accounts/#{params[:idT]}", notice: 'Datos actualizados.' if edit_account.save
  else
    redirect "/dashboard/teachers/bank_accounts/#{params[:idT]}/edit/#{params[:idC]}", flash[:error] = edit_account.errors.full_messages
  end
end
