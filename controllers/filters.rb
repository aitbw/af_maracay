# Filtros para restringir acceso bajo ciertas condiciones
before %r{\/dashboard\/(users\/*|teachers\/\d\/bank_accounts\/*)} do
  # TO-DO: halt erb(:not_authorized)
  # Restringir acceso a las siguientes rutas:
  # '/dashboard/wages'
  # '/dashboard/reports'
  redirect '/dashboard' if session[:role] != 'Admin'
end

before %r{\/dashboard\/*} do
  if session[:id].nil?
    flash[:error] = I18n.t('signin.messages.errors.nil_session')
    redirect '/signin'
  end
end

before '/signin' do
  redirect '/dashboard' if session[:id]
end
