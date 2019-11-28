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
      extend Virtuatable::Builders::Helpers::Loaders
      # Include all the helpers now that loaders can be declared.
      include Virtuatable::Builders::Helpers::Controllers
      include Virtuatable::Builders::Helpers::Environment
      include Virtuatable::Builders::Helpers::Mongoid

      # @!attribute [rw] directory
      #   @return [String] the directory from which the application is loaded.
      #     In most case, just pass __dir__ from the config.ru file.
      attr_accessor :directory
      # The mode can be either development or test depending on what loads the service.
      #   @return [Symbol] :test or :development depending on what you're trying to
      #     load the service for.
      attr_reader :mode

      # Constructor of the builder, initializing needed attributes.
      # @param directory [String] the directory from which load the application.
      def initialize(locations: caller_locations, path: '.')
        # The base folder of the file calling the builder
        filedir = File.dirname(locations.first.absolute_path)
        @directory = File.absolute_path(File.join(filedir, path))
        @mode = :development
      end

      def load!
        loaders.each do |loader|
          send(:"load_#{loader}!")
        end
      end
    end
  end
end
