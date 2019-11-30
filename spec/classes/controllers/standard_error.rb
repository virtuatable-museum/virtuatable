module Controllers
  class StandardError < Virtuatable::Controllers::Base
    get '/exception' do
      raise StandardError.new
    end
  end
end