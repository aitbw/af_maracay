# app.rb

require 'bundler/setup'
Bundler.require(:default)
require './environments'
Dir['./controllers/*.rb', './models/*.rb', './routes/*.rb'].each { |file| require file }

configure do
  enable :sessions
  set :session_secret, SecureRandom.hex(64)
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

helpers do
  def set_page_title(title)
    @page_title = title
  end

  def user_layout
    case session[:role]
    when 'Admin'
      { layout: :'layouts/admin' }
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
  # TO-DO: 404 erb(:not_found)
  status 404
end

after do
  ActiveRecord::Base.connection.close
end
