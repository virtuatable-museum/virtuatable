# frozen_string_literal: true

module Virtuatable
  module Helpers
    # This module provides the #current_route method to get the current
    # Arkaan::Monitoring::Route object from whithin sinatra routes.
    # @author Vincent Courtois <courtois.vincent@outlook.com>
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
