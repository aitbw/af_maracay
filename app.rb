# app.rb

require 'bundler/setup'
Bundler.require(:default, :development)
require 'tilt/erubis'
require './environments'
Dir['./controllers/*.rb', './models/*.rb', './routes/*.rb'].each { |file| require file }

enable :sessions
set :session_secret, SecureRandom.hex(64)

helpers do
  def titulo(title)
    @page_title = title
  end

  include Rack::Utils
  alias_method :h, :escape_html
end

get '/signin' do
  erb :signin
end

post '/signin' do
  if (params[:cedula] || params[:password]).blank?
    redirect '/signin', error: 'Debe completar todos los campos.'
  else
    authenticate(params[:cedula], params[:password])
  end
end

get '/dashboard' do
  titulo('Inicio')
  erb :index, layout: :'layouts/dashboard'
end

get '/logout' do
  session.clear
  redirect '/signin', notice: 'Usted ha cerrado sesión.'
end

not_found do
  # TO-DO: 404 erb(:not_found)
  status 404
end

after do
  ActiveRecord::Base.connection.close
end
