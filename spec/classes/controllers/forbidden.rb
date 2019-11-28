module Controllers
  class Forbidden < Virtuatable::Controllers::Base
    get '/method' do
      api_forbidden 'field.forbidden'
    end
    get '/exception' do
      raise Virtuatable::API::Errors::Forbidden.new(
        field: 'field',
        error: 'forbidden'
      )
    end
  end
end