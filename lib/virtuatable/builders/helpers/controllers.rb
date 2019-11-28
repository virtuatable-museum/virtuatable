# frozen_string_literal: true

module Virtuatable
  module Builders
    module Helpers
      # Loading helpers to require and map all controllers classes inside a service.
      # A controller is defined as a class inside de "Controllers" root module.
      # If the module "Controllers" has not been defined, the list of controllers is
      # always empty, as no controller can be loaded.
      #
      # @author Vincent Courtois <courtois.vincent@outlook.com>
      module Controllers
        # Loads all of the controllers, given that the /controllers folder
        # has already been fully required, therefore all constants are declared.
        def controllers
          return [] if defined?(::Controllers).nil?
          classes = Controllers.constants.map { |symbol| get_const(symbol) }
          classes.select { |symbol| symbol.is_a? Class }
        end
      end
    end
  end
end
