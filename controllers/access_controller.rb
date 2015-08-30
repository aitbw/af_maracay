# Controlador para restringir acceso a:
# Control de usuarios y salarios
# Generar reportes
def restrict_access
  before %r{^\/(dashboard\/users|dashboard\/users\/*)} do
    # TO-DO: halt erb(:not_authorized)
    # Restringir acceso a las siguientes rutas:
    # '/dashboard/wages'
    # '/dashboard/reports'
    redirect '/dashboard' if session[:rol] != 'Admin'
  end
end
