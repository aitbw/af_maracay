# config.ru

require './app'
require './config/cookie_settings'
run Sinatra::Application
