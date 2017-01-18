def start_session(user)
  session[:id] = user.user_id
  session[:name] = user.user_name
  session[:role] = user.access_level
  redirect '/dashboard'
end

def account_locked?(user)
  if user.has_access == true
    start_session(user)
  else
    redirect '/signin', error: I18n.t('signin.messages.errors.locked_account')
  end
end

def authenticate(cedula, password)
  @user = User.find_by(user_cedula: cedula)
  @user_hash = BCrypt::Password.new(@user.user_password)

  if @user_hash == password
    account_locked?(@user)
  else
    flash[:error] = I18n.t('signin.messages.errors.mismatched_params')
    redirect '/signin'
  end
end

def user_exists?(cedula)
  if User.where(user_cedula: cedula).present?
    authenticate(cedula, params[:password])
  else
    redirect '/signin', error: I18n.t('signin.messages.errors.not_found')
  end
end
