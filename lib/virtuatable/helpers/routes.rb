module Virtuatable
  module Helpers
    module Routes
      def current_route
        splitted = request.env['sinatra.route'].split(' ')
        verb = splitted.first.downcase
        Arkaan::Monitoring::Route.find_by(verb: verb, path: splitted.last)
      end
    end
  end
end