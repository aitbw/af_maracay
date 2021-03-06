configure :development do
  Bundler.require(:development)
  set :show_exceptions, true
  enable :logging

  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)

  Bullet.enable = true
  Bullet.alert = true
  Bullet.bullet_logger = true
  Bullet.console = true
  use Bullet::Rack
end
