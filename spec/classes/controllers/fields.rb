module Controllers
  class Fields < Virtuatable::Controllers::Base
    get '/fields' do
      check_either_presence 'key', 'other', key: 'custom_label'
    end
  end
end