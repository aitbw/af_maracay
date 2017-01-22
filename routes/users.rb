get '/dashboard/users' do
  set_page_title(I18n.t('users.page_titles.main'))
  @users = User.search_user(params[:cedula]).page(params[:page])
  erb :'users/users', layout: :'layouts/main'
end

get '/dashboard/users/new_user' do
  set_page_title(I18n.t('users.page_titles.new_user'))
  @roles = {
    Admin: I18n.t('users.data.roles.admin'),
    Educator: I18n.t('users.data.roles.educator'),
    Clerk: I18n.t('users.data.roles.clerk')
  }

  erb :'users/new_user', layout: :'layouts/main'
end

post '/dashboard/users/new_user' do
  new_user = User.new(params[:user])

  if new_user.save
    flash[:notice] = I18n.t('users.messages.success.created_user')
    redirect '/dashboard/users'
  else
    flash[:errors] = new_user.errors
    redirect(request.path_info.to_s)
  end
end

get '/dashboard/users/:id/delete' do
  set_page_title(I18n.t('users.page_titles.delete_user'))
  @user = User.find(params[:id])
  erb :'users/delete_user', layout: :'layouts/main'
end

delete '/dashboard/users/:id/delete' do
  if User.destroy(params[:id])
    flash[:notice] = I18n.t('users.messages.success.deleted_user')
    redirect '/dashboard/users'
  else
    flash[:error] = I18n.t('users.messages.errors.failed_transaction')
    redirect(request.path_info.to_s)
  end
end

get '/dashboard/users/:id/edit' do
  set_page_title(I18n.t('users.page_titles.edit_user'))
  @roles = {
    Admin: I18n.t('users.data.roles.admin'),
    Educator: I18n.t('users.data.roles.educator'),
    Clerk: I18n.t('users.data.roles.clerk')
  }

  @user = User.find(params[:id])
  erb :'users/edit_user', layout: :'layouts/main'
end

put '/dashboard/users/:id/edit' do
  edit_user = User.find(params[:id])
  if edit_user.update(params[:user])
    flash[:notice] = I18n.t('users.messages.success.updated_user')
    redirect '/dashboard/users'
  else
    flash[:errors] = edit_user.errors
    redirect(request.path_info.to_s)
  end
end

get '/dashboard/change_password' do
  set_page_title(I18n.t('users.page_titles.change_password'))
  erb :'users/change_password', layout: :'layouts/main'
end

put '/dashboard/change_password' do
  if (params[:password] || params[:confirm]).blank?
    flash[:error] = I18n.t('users.messages.errors.empty_fields')
  elsif params[:password] != params[:confirm]
    flash[:error] = I18n.t('users.messages.errors.mismatched_params')
  else
    change_password
  end
  redirect(request.path_info.to_s)
end

get '/dashboard/users/:id/reset_password' do
  set_page_title(I18n.t('users.page_titles.reset_password'))
  @user_id = params[:id]
  erb :'users/reset_password', layout: :'layouts/main'
end

put '/dashboard/users/:id/reset_password' do
  if (params[:password] || params[:confirm]).blank?
    flash[:error] = I18n.t('users.messages.errors.empty_fields')
  elsif params[:password] != params[:confirm]
    flash[:error] = I18n.t('users.messages.errors.mismatched_params')
  else
    reset_password
  end
  redirect(request.path_info.to_s)
end

put '/dashboard/users/:id/lock_account' do
  content_type :json
  user = User.find(params[:id])

  if user.update(has_access: false)
    { message: I18n.t('users.messages.success.locked_account') }.to_json
  else
    halt 400, I18n.t('users.messages.errors.failed_transaction')
  end
end

put '/dashboard/users/:id/unlock_account' do
  content_type :json
  user = User.find(params[:id])

  if user.update(has_access: true)
    { message: I18n.t('users.messages.success.unlocked_account') }.to_json
  else
    halt 400, I18n.t('users.messages.errors.failed_transaction')
  end
end
