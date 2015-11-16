# Helpers to keep exception handling DRY
def find_teacher(id)
  Teacher.find(id).present?
rescue ActiveRecord::RecordNotFound
  redirect '/dashboard/teachers', error: 'El profesor no existe.'
end

def find_account(teacher, account)
  BankAccount.find(account).present?
rescue ActiveRecord::RecordNotFound
  flash[:error] = 'La cuenta asociada no existe.'
  redirect "/dashboard/teachers/#{teacher}/bank_accounts"
end

before %r{\/dashboard\/teachers\/(\d)\/(delete|edit)} do |id, _|
  find_teacher(id)
end

before %r{\/dashboard\/teachers\/(\d)\/bank_accounts\/(\d)\/(delete|edit)} do |teacher, account, _|
  find_teacher(teacher) && find_account(teacher, account)
end

get '/dashboard/teachers' do
  set_page_title('Profesores')
  @teachers = Teacher.all
  erb :teachers, layout: :'layouts/dashboard'
end

get '/dashboard/teachers/new_teacher' do
  set_page_title('Crear nuevo profesor')
  @js = ['moment.min.js', 'bootstrap-datetimepicker.min.js']
  erb :new_teacher, layout: :'layouts/dashboard'
end

post '/dashboard/teachers/new_teacher' do
  new_teacher
end

get '/dashboard/teachers/:id/delete' do
  @teacher = Teacher.find(params[:id])
  set_page_title('Eliminar profesor')
  erb :delete_teacher, layout: :'layouts/dashboard'
end

delete '/dashboard/teachers/:id/delete' do
  if Teacher.destroy(params[:id])
    redirect '/dashboard/teachers', notice: 'Profesor eliminado.'
  else
    flash[:error] = 'Ha ocurrido un error, intente nuevamente.'
    redirect "#{request.path_info}"
  end
end

get '/dashboard/teachers/:id/edit' do
  @teacher = Teacher.find(params[:id])
  set_page_title('Editar profesor')
  erb :edit_teacher, layout: :'layouts/dashboard'
end

put '/dashboard/teachers/:id/edit' do
  edit_teacher = Teacher.find(params[:id])
  edit_teacher.update(params[:teacher])
  if edit_teacher.save
    redirect '/dashboard/teachers', notice: 'Datos actualizados.'
  else
    flash[:errors] = edit_teacher.errors.full_messages
    redirect "#{request.path_info}"
  end
end

get '/dashboard/teachers/:id/bank_accounts' do
  if find_teacher(params[:id])
    set_page_title('Cuentas bancarias')
    @teacher_id = params[:id]
    @accounts = BankAccount.where(teacher_id: params[:id])
    erb :bank_accounts, layout: :'layouts/dashboard'
  end
end

get '/dashboard/teachers/:id/bank_accounts/add' do
  if find_teacher(params[:id])
    set_page_title('Asignar cuenta bancaria')
    @teacher_id = params[:id]
    @banks = Bank.all
    erb :add_bank_account, layout: :'layouts/dashboard'
  end
end

post '/dashboard/teachers/:id/bank_accounts/add' do
  assign_account if find_teacher(params[:id])
end

get '/dashboard/teachers/:teacher/bank_accounts/:account/delete' do
  set_page_title('Eliminar cuenta bancaria')
  @account = BankAccount.find(params[:account])
  erb :delete_bank_account, layout: :'layouts/dashboard'
end

delete '/dashboard/teachers/:teacher/bank_accounts/:account/delete' do
  if BankAccount.destroy(params[:account])
    flash[:notice] = 'Cuenta bancaria eliminada.'
    redirect "/dashboard/teachers/#{params[:teacher]}/bank_accounts"
  else
    flash[:error] = 'Ha ocurrido un error, intente nuevamente.'
    redirect "#{request.path_info}"
  end
end

get '/dashboard/teachers/:teacher/bank_accounts/:account/edit' do
  set_page_title('Editar cuenta bancaria')
  @account = BankAccount.find(params[:account])
  @banks = Bank.all
  erb :edit_bank_account, layout: :'layouts/dashboard'
end

put '/dashboard/teachers/:teacher/bank_accounts/:account/edit' do
  edit_account = BankAccount.find(params[:account])
  edit_account.update(params[:form])
  if edit_account.save
    flash[:notice] = 'Datos actualizados.'
    redirect "/dashboard/teachers/#{params[:teacher]}/bank_accounts"
  else
    flash[:errors] = edit_account.errors.full_messages
    redirect "#{request.path_info}"
  end
end
