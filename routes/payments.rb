get '/dashboard/students/:id/signups' do
  set_page_title(I18n.t('payments.page_titles.signups'))
  @student = Student.find(params[:id])
  @signups = Payment.where('payment_description = ? AND student_id = ?', 'Inscripción', params[:id]).includes(:user).page(params[:page])
  erb :'signups/signups', user_layout
end

get '/dashboard/students/:id/signups/new' do
  set_page_title(I18n.t('payments.page_titles.new_signup'))
  @student = Student.find(params[:id])
  @banks = Bank.all
  erb :'signups/new_signup', user_layout
end

post '/dashboard/students/:id/signups/new' do
  new_signup = Payment.new(params[:payment])

  if new_signup.save
    flash[:notice] = I18n.t('payments.messages.success.created_signup')
    redirect "/dashboard/students/#{params[:id]}/signups"
  else
    flash[:errors] = new_signup.errors.full_messages
    redirect(request.path_info.to_s)
  end
end

get '/dashboard/students/:student/signups/:signup/delete' do
  set_page_title(I18n.t('payments.page_titles.delete_signup'))
  @signup = Payment.find(params[:signup])
  erb :'signups/delete_signup', user_layout
end

delete '/dashboard/students/:student/signups/:signup/delete' do
  if Payment.destroy(params[:signup])
    flash[:notice] = I18n.t('payments.messages.success.deleted_signup')
    redirect "/dashboard/students/#{params[:student]}/signups"
  else
    flash[:error] = I18n.t('payments.messages.errors.failed_transaction')
    redirect(request.path_info.to_s)
  end
end

get '/dashboard/students/:student/signups/:signup/edit' do
  set_page_title(I18n.t('payments.page_titles.edit_signup'))
  @signup = Payment.find(params[:signup])
  @banks = Bank.all
  erb :'signups/edit_signup', user_layout
end

put '/dashboard/students/:student/signups/:signup/edit' do
  edit_signup = Payment.find(params[:signup])

  if edit_signup.update(params[:form])
    flash[:notice] = I18n.t('payments.messages.success.updated_record')
    redirect "/dashboard/students/#{params[:student]}/signups"
  else
    flash[:errors] = edit_signup.errors.full_messages
    redirect(request.path_info.to_s)
  end
end

get '/dashboard/students/:id/fees' do
  set_page_title(I18n.t('payments.page_titles.fees'))
  @student = Student.find(params[:id])
  @fees = Payment.where('payment_description = ? AND student_id = ?', 'Cuota', params[:id]).includes(:user).page(params[:page])
  erb :'fees/fees', user_layout
end

get '/dashboard/students/:id/fees/new' do
  set_page_title(I18n.t('payments.page_titles.new_fee'))
  @student = Student.find(params[:id])
  @banks = Bank.all
  erb :'fees/new_fee', user_layout
end

post '/dashboard/students/:id/fees/new' do
  new_fee = Payment.new(params[:payment])

  if new_fee.save
    flash[:notice] = I18n.t('payments.messages.success.created_fee')
    redirect "/dashboard/students/#{params[:id]}/fees"
  else
    flash[:errors] = new_fee.errors.full_messages
    redirect(request.path_info.to_s)
  end
end

get '/dashboard/students/:student/fees/:fee/delete' do
  set_page_title(I18n.t('payments.page_titles.delete_fee'))
  @fee = Payment.find(params[:fee])
  erb :'fees/delete_fee', user_layout
end

delete '/dashboard/students/:student/fees/:fee/delete' do
  if Payment.destroy(params[:fee])
    flash[:notice] = I18n.t('payments.messages.success.deleted_fee')
    redirect "/dashboard/students/#{params[:student]}/fees"
  else
    flash[:error] = I18n.t('payments.messages.errors.failed_transaction')
    redirect(request.path_info.to_s)
  end
end

get '/dashboard/students/:student/fees/:fee/edit' do
  set_page_title(I18n.t('payments.page_titles.edit_fee'))
  @banks = Bank.all
  @fee = Payment.find(params[:fee])
  erb :'fees/edit_fee', user_layout
end

put '/dashboard/students/:student/fees/:fee/edit' do
  edit_fee = Payment.find(params[:fee])

  if edit_fee.update(params[:form])
    flash[:notice] = I18n.t('payments.messages.success.updated_record')
    redirect "/dashboard/students/#{params[:student]}/fees"
  else
    flash[:errors] = edit_fee.errors.full_messages
    redirect(request.path_info.to_s)
  end
end
