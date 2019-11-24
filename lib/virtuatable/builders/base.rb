# frozen_string_literal: true

module Virtuatable
  # The builders classes declares the micro service at startup in one of the services
  # It provides chainable methods to be able to configure and correctly launch the
  # micro-service by requiring dependencies, files, and mounting controllers.
  #
  # @author Vincent Courtois <courtois.vincent@outlook.com>
  module Builders
    # The base class provides methods to load all elements of the application.
    # @author Vincent Courtois <courtois.vincent@outlook.com>
    class Base
      include Singleton
      include Virtuatable::Builders::Helpers::Environment
      include Virtuatable::Builders::Helpers::Controllers

      # @!attribute [rw] directory
      #   @return [String] the directory from which the application is loaded.
      #     In most case, just pass __dir__ from the config.ru file.
      attr_accessor :directory

      # Constructor of the builder, initializing needed attributes.
      # @param directory [String] the directory from which load the application.
      def initialize
        @directory = File.dirname(caller_locations.first.absolute_path)
      end
    end
  end
end
