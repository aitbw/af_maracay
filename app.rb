# app.rb

require 'bundler/setup'
Bundler.require(:default)
require './init'

configure do
  enable :sessions
  set :session_secret, ENV.fetch('SESSION_SECRET') { SecureRandom.hex(64) }
  I18n::Backend::Simple.send(:include, I18n::Backend::Fallbacks)
  I18n.load_path = Dir[File.join(settings.root, 'config/locales', 'es.yml')]
  I18n.backend.load_translations
  I18n.enforce_available_locales = false
  I18n.available_locales = ['es']
  I18n.default_locale = :es
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
  def current_user_is_admin?
    return true if session[:role] == 'Admin'
  end

  def render_menu(options = {})
    case session[:role]
    when 'Admin'
      erb :'menus/admin', options.merge!(layout: false)
    when 'Clerk'
      erb :'menus/clerk', options.merge!(layout: false)
    when 'Educator'
      erb :'menus/educator', options.merge!(layout: false)
    end
  end

  def set_page_title(title)
    @page_title = title
  end

  include Rack::Utils
  alias_method :h, :escape_html
end

get '/?' do
  redirect to('/signin')
end

get '/signin' do
  erb :signin
end

post '/signin' do
  if (params[:cedula] || params[:password]).blank?
    redirect '/signin', error: I18n.t('signin.messages.errors.empty_fields')
  else
    user_exists?(params[:cedula])
  end
end

get '/dashboard' do
  set_page_title(I18n.t('dashboard.page_title'))
  @expired_signups = Payment.where(
    'payment_status = ? AND expiration_date <= ?',
    'Inscripción vigente', Date.today
  )

  @expired_fees = Payment.where(
    'payment_status = ? AND expiration_date <= ?',
    'Cuota vigente', Date.today
  )
  erb :index, layout: :'layouts/main'
end

get '/logout' do
  session.clear
  redirect '/signin', notice: I18n.t('signin.messages.success.signout')
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
