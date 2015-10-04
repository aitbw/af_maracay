Rack::Builder.new do
  use Rack::Csrf, raise: true
end
