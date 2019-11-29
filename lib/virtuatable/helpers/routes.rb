# frozen_string_literal: true

module Virtuatable
  module Helpers
    # This helpers module is a bit larger than the others as it provides methods
    # to declare routes whithin a service, performing needed checks and filters.
    # @author Vincent Courtois <courtois.vincent@outlook.com>
    module Routes
      # Main method to declare new routes, persisting them in the database and
      # declaring it in the Sinatra application with the needed before checks.
      #
      # @param verb [String] the HTTP method for the route.
      # @param path [String] the whole URI with parameters for the route.
      # @param options [Hash] the additional options for the route.
      def self.api_route(verb, path, options: {}); end

      def builder
        Virtuatable::Builder::Base.instance
      end
    end
  end
end
