def check_session
  before %r{^\/(dashboard|dashboard\/*)} do
    if session[:cedula].nil?
      redirect '/signin', error: 'Debe iniciar sesión para acceder al panel de control.'
    end
  end
end
