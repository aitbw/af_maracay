get '/dashboard/teachers/:id/bank_accounts' do
  @teacher = Teacher.find(params[:id])
  @accounts = BankAccount.where(teacher_id: params[:id]).includes(:bank)
  set_page_title(
    I18n.t(
      'bank_accounts.page_titles.bank_accounts',
      teacher_name: @teacher.teacher_name
    )
  )

  erb :'bank_accounts/bank_accounts', layout: :'layouts/main'
end

get '/dashboard/teachers/:id/bank_accounts/new' do
  set_page_title(I18n.t('bank_accounts.page_titles.new_bank_account'))
  @banks = Bank.all
  erb :'bank_accounts/new_bank_account', layout: :'layouts/main'
end

post '/dashboard/teachers/:id/bank_accounts/new' do
  new_account = BankAccount.new(params[:account])
  new_bank_account(new_account)
end

get '/dashboard/teachers/:teacher/bank_accounts/:account/delete' do
  set_page_title(I18n.t('bank_accounts.page_titles.delete_bank_account'))
  @account = BankAccount.find(params[:account])
  erb :'bank_accounts/delete_bank_account', layout: :'layouts/main'
end

delete '/dashboard/teachers/:teacher/bank_accounts/:account/delete' do
  delete_bank_account
end

get '/dashboard/teachers/:teacher/bank_accounts/:account/edit' do
  set_page_title(I18n.t('bank_accounts.page_titles.edit_bank_account'))
  @account = BankAccount.find(params[:account])
  @banks = Bank.all
  erb :'bank_accounts/edit_bank_account', layout: :'layouts/main'
end

put '/dashboard/teachers/:teacher/bank_accounts/:account/edit' do
  @edit_account = BankAccount.find(params[:account])
  edit_bank_account(@edit_account, params[:account])
end
