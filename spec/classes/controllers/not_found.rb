module Controllers
  class NotFound < Virtuatable::Controllers::Base
    get '/method' do
      api_not_found 'field.unknown'
    end
    get '/exception' do
      raise Virtuatable::API::Errors::NotFound.new(
        field: 'field',
        error: 'unknown'
      )
    end
  end
end