module Virtuatable
  module Helpers
    module Routes
      def current_route
        splitted = request.env['sinatra.route'].split(' ')
        verb = splitted.first.downcase
        self.class.api_routes.find do |route|
          route.verb == verb && route.path == splitted.last
        end
      end
    end
  end
end