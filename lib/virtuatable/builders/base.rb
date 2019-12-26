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
      # @param locations [Array<String>] you should not modify this parameter, it
      #   determines from which folder the application is supposed to be loaded.
      # @param path [String] the path from the loaded directory that leads to
      #   the root of the application (to find all other files and folders)
      # @param name [String] the name of the loaded service, determining its url.
      def initialize(locations: caller_locations, path: '.', name:)
        # The base folder of the file calling the builder
        filedir = File.dirname(locations.first.absolute_path)
        @directory = File.absolute_path(File.join(filedir, path))
        @mode = (ENV['RACK_ENV'] || 'development').to_sym
        @name = name.to_s
      end

      # Main method to load the application. This method is called after creating
      # a builder in the Virtuatable::Application class.
      def load!
        all_loaders.each do |loader|
          send(:"load_#{loader[:name]}!")
        end
      end

      # Checks the presence of all the needed environment variables.
      # @raise [Virtuatable::Builders::Errors::MissingEnv] if a variable is not present,
      #   for a variable to be present she has to be a key of the ENV constant.
      def check_variables!
        names = %w[INSTANCE_TYPE SERVICE_URL APP_KEY]
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
      # @param folders [Array<String>] the folders names passed as parameters.
      def require_folders(*folders)
        folders.each do |folder|
          base_path = File.join(folder, 'base.rb')
          require base_path if File.exist?(base_path)
          path = File.join(directory, folder)
          require_all(path) if File.directory?(path)
        end
      end

      # Returns the ancestors of this class without the included modules.
      # Ruby puts the included modules in the ancestors and we don't want to
      # search for the loaders in it as we know it won't be there.
      # @return [Array<Class>] the ancestors of the class without included modules.
      def sanitized_ancestors
        self.class.ancestors - self.class.included_modules
      end

      # Gets the loaders of the current class and all its ancestors that have loaders
      # @return [Array<Symbol>] the name of the loaders declared.
      def all_loaders
        superclasses = sanitized_ancestors.reject do |ancestor|
          ancestor == self.class
        end
        ancestors_loaders = superclasses.map do |ancestor|
          ancestor.respond_to?(:loaders) ? ancestor.loaders : []
        end
        flattened_loaders = (ancestors_loaders + self.class.loaders).flatten
        flattened_loaders.sort_by { |loader| loader[:priority] }
      end
    end
  end
end
