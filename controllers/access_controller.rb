def restrict_access
  before %r{^\/(dashboard\/users|dashboard\/users\/*)} do
    # TO-DO: halt erb(:not_authorized)
    redirect '/dashboard' if session[:rol] != 'Admin'
  end
end
