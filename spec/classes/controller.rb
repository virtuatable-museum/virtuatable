class Controller < Virtuatable::Controllers::Base
  get '/not_found_method' do
    api_not_found 'field.unknown'
  end
  get '/not_found_exception' do
    raise Virtuatable::API::Errors::NotFound.new(
      field: 'field',
      error: 'unknown'
    )
  end
end