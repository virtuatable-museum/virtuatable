module Controllers
  class BadRequest < Virtuatable::Controllers::Base
    get '/method' do
      api_bad_request 'field.required'
    end
    get '/exception' do
      raise Virtuatable::API::Errors::BadRequest.new(
        field: 'field',
        error: 'required'
      )
    end
  end
end