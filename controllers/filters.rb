# Filtros para restringir acceso bajo ciertas condiciones
before %r{^\/dashboard\/users\/*|\/dashboard\/teachers\/bank_accounts\/*} do
  # TO-DO: halt erb(:not_authorized)
  # Restringir acceso a las siguientes rutas:
  # '/dashboard/wages'
  # '/dashboard/reports'
  redirect '/dashboard' if session[:rol] != 'Admin'
end

before %r{^\/dashboard\/*} do
  if session[:id].nil?
    redirect '/signin', error: 'Debe iniciar sesión para acceder al panel de control.'
  end
end

before '/signin' do
  redirect '/dashboard' if session[:id]
end
