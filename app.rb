# app.rb

require 'bundler/setup'
Bundler.require(:default)
require './environments'
Dir['./controllers/*.rb', './models/**/*.rb', './routes/*.rb'].each do |file|
  require file
end

configure do
  enable :sessions
  set :session_secret, SecureRandom.hex(64)
  # use Sinatra::CacheAssets, max_age: 86_400
  Rack::Builder.new do
    cookie_settings = {
      path: '/',
      expire_after: 86_400,
      secure: true,
      httponly: true
    }
    use Rack::Session::EncryptedCookie, cookie_settings
    use Rack::Csrf, raise: true
  end
end

before do
  # cache_control :public, :must_revalidate
  headers['Cache-Control'] = 'no-cache, no-store, max-age=0, must-revalidate'
  headers['Pragma'] = 'no-cache'
  headers['Expires'] = 'Fri, 01 Jan 1990 00:00:00 GMT'
end

helpers do
  def set_page_title(title)
    @page_title = title
  end

  def user_layout
    case session[:role]
    when 'Admin'
      { layout: :'layouts/admin' }
    when 'Pedagogo'
      { layout: :'layouts/educator' }
    when 'Recepcionista'
      { layout: :'layouts/clerk' }
    end
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
    user_exists?(params[:cedula])
  end
end

get '/dashboard' do
  set_page_title('Inicio')
  @expired_signups = Signup.where(
  'signup_status = ? AND is_latest_signup = ?', 'Inscripción expirada', true)

  @expired_fees = Fee.where(
  'fee_status = ? AND is_latest_fee = ?', 'Cuota expirada', true)
  erb :index, user_layout
end

get '/logout' do
  session.clear
  redirect '/signin', notice: 'Usted ha cerrado sesión.'
end

not_found do
  status 404
  # erb :'errors/404', user_layout
end

error ActiveRecord::RecordNotFound do
  # TO-DO
  # erb :'errors/404', user_layout
end

after do
  ActiveRecord::Base.connection.close
end
