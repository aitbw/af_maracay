configure :development do
  require 'better_errors'
  set :show_exceptions, true
  enable :logging

  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end
