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
      # We include this module only for test purposes to mock require_all
      include RequireAll
      # Include all the helpers now that loaders can be declared.
      include Virtuatable::Builders::Helpers::Controllers
      include Virtuatable::Builders::Helpers::Environment
      include Virtuatable::Builders::Helpers::Folders
      include Virtuatable::Builders::Helpers::Mongoid
      include Virtuatable::Builders::Helpers::Registration

      # @!attribute [r] directory
      #   @return [String] the directory from which the application is loaded.
      #     In most case, just pass __dir__ from the config.ru file.
      attr_reader :directory
      # @!attribute [r] mode
      #   @return [Symbol] :test or :development depending on what you're trying to
      #     load the service for.
      attr_reader :mode
      # @!attribute [rw] name
      #   @return [String] the name of the micro-service.
      attr_accessor :name

      # Constructor of the builder, initializing needed attributes.
      # @param directory [String] the directory from which load the application.
      def initialize(locations: caller_locations, path: '.', name:)
        # The base folder of the file calling the builder
        filedir = File.dirname(locations.first.absolute_path)
        @directory = File.absolute_path(File.join(filedir, path))
        @mode = :development
        @name = name.to_s
      end

      def load!
        all_loaders.each do |loader|
          send(:"load_#{loader}!")
        end
      end

      # Checks the presence of all the needed environment variables.
      # @raise [Virtuatable::Builders::Errors::MissingEnv] if a variable is not present,
      #   for a variable to be present she has to be a key of the ENV constant.
      def check_variables!
        names = ['INSTANCE_TYPE']
        names.each do |varname|
          exception_klass = Virtuatable::Builders::Errors::MissingEnv
          raise exception_klass.new(variable: varname) unless ENV.key?(varname)
        end
      end

      # Returns the type of the instance, default being a UNIX server
      # @return [Symbol] the type of instance currently loading.
      def type
        ENV['INSTANCE_TYPE'].nil? ? :unix : ENV['INSTANCE_TYPE'].to_sym
      end

      # Loads a list of folders given as method parameters
      # @param *folders [Array<String>] the folders names passed as parameters.
      def require_folders(*folders)
        folders.each do |folder|
          path = File.join(directory, folder)
          require_all(path) if File.directory?(path)
        end
      end

      # Gets the loaders of the current class and all its ancestors that have loaders
      # @return [Array<Symbol>] the name of the loaders declared.
      def all_loaders
        ancestors_loaders = self.class.ancestors.map do |ancestor|
          ancestor.respond_to?(:loaders) ? ancestor.loaders : []
        end
        (self.class.loaders + ancestors_loaders.flatten).uniq
      end
    end
  end
end
