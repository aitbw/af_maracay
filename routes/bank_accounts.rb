get '/dashboard/teachers/:id/bank_accounts' do
  set_page_title('Cuentas bancarias')
  @teacher = Teacher.find(params[:id])
  @accounts = BankAccount.where(teacher_id: params[:id])
  erb :'bank_accounts/bank_accounts', user_layout
end

get '/dashboard/teachers/:id/bank_accounts/new' do
  set_page_title('Crear cuenta bancaria')
  @banks = Bank.all
  erb :'bank_accounts/new_bank_account', user_layout
end

post '/dashboard/teachers/:id/bank_accounts/new' do
  new_bank_account
end

get '/dashboard/teachers/:teacher/bank_accounts/:account/delete' do
  set_page_title('Eliminar cuenta bancaria')
  @account = BankAccount.find(params[:account])
  erb :'bank_accounts/delete_bank_account', user_layout
end

delete '/dashboard/teachers/:teacher/bank_accounts/:account/delete' do
  delete_bank_account
end

get '/dashboard/teachers/:teacher/bank_accounts/:account/edit' do
  set_page_title('Editar cuenta bancaria')
  @account = BankAccount.find(params[:account])
  @banks = Bank.all
  erb :'bank_accounts/edit_bank_account', user_layout
end

put '/dashboard/teachers/:teacher/bank_accounts/:account/edit' do
  @edit_account = BankAccount.find(params[:account])
  edit_bank_account(@edit_account)
end
