module Controllers
  class Parameters < Virtuatable::Controllers::Base
    post '/body/:id' do
      halt 200, parameters.to_json
    end
    get '/querystring/:id' do
      halt 200, parameters.to_json
    end
    post '/both/:id' do
      halt 200, parameters.to_json
    end
  end
end