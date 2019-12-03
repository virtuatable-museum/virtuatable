def create_non_premium_apps_controller
  Class.new(Sinatra::Base) do
    extend Virtuatable::Helpers::Declarators

    api_route 'GET', '/path', options: {premium: true}
  end
end