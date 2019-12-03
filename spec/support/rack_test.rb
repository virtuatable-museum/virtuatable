puts "> Configuration des méthodes de Rack::Test"
RSpec.configure do |config|
  config.include Rack::Test::Methods
end