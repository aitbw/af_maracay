def change_password
  user = User.find(session[:id])
  user.user_password = BCrypt::Password.create(params[:password])

  if user.save
    flash[:notice] = I18n.t('users.messages.success.password_change')
  else
    flash[:error] = I18n.t('users.messages.errors.failed_transaction')
  end
end

def reset_password
  user = User.find(params[:id])
  user.user_password = BCrypt::Password.create(params[:password])

  if user.save
    flash[:notice] = I18n.t('users.messages.success.password_reset')
    redirect '/dashboard/users'
  else
    flash[:error] = I18n.t('users.messages.errors.failed_transaction')
  end
end
