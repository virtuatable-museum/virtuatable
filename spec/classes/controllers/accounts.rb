module Controllers
  class Accounts < Virtuatable::Controllers::Base
    get '/account' do
      halt 200, {id: account.id.to_s}.to_json
    end
    get '/session' do
      halt 200, {id: session!.id.to_s}.to_json
    end
    get '/exception' do
      account!
    end
  end
end