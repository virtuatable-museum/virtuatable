# Class to check if mongoid errors are caught and formatted
module Controllers
  class Mongoid < Virtuatable::Controllers::Base
    get '/exception' do
      # No username -> error
      Arkaan::Account.new(email: 'email.test.com').save!
    end
  end
end