# frozen_string_literal: true

module Virtuatable
  module Helpers
    # This helpers module is a bit larger than the others as it provides methods
    # to declare routes whithin a service, performing needed checks and filters.
    # @author Vincent Courtois <courtois.vincent@outlook.com>
    module Routes
      # @!attribute [r] routes
      #   @return [Array<Arkaan::Monitoring::Route>] the currently declared routes.
      attr_reader :routes

      # Main method to declare new routes, persisting them in the database and
      # declaring it in the Sinatra application with the needed before checks.
      #
      # @param verb [String] the HTTP method for the route.
      # @param path [String] the whole URI with parameters for the route.
      # @param options [Hash] the additional options for the route.
      def api_route(verb, path, options: {})
        options = default_options.merge(options)
        route = add_route(verb: verb, path: path, options: options)
      end

      # Add a route to the database, then to the routes array.
      # @param verb [String] the HTTP method used to request this route.
      # @param path [String] the path used to request this route.
      # @return [Arkaan::Monitoring::Route] the created route.
      def add_route(verb:, path:, options:)
        route = Arkaan::Monitoring::Route.first_or_create!(
          path: complete_path(path),
          verb: verb.downcase,
          premium: options[:premium],
          service: builder.service,
          authenticated: options[:authenticated]
        )
        routes.nil? ? @routes = [route] : push_route(route)
        route
      end

      def push_route(route)
        @routes << route if routes.none? do |tmp_route|
          route.id == tmp_route.id
        end
      end

      def complete_path(path)
        service_path = builder.service.path == '/' ? '' : builder.service.path
        "#{service_path}#{path}"
      end

      # Returns the current builder loading the application.
      # @return [Virtuatable::Builers::Base] the current builder of the application.
      def builder
        Virtuatable::Application.builder
      end

      # The default options for a route, being the most used value for each key.
      # @return [Hash] the default options as a hash.
      def default_options
        {
          # If TRUE the application MUST be premium to access the route.
          # Mainly used to protect administration routes against illegal accesses.
          premium: false,
          # If TRUE the user MUST be authenticated to access the route.
          authenticated: true
        }
      end
    end
  end
end
