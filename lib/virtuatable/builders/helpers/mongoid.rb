# frozen_string_literal: true

module Virtuatable
  module Builders
    module Helpers
      # Loads the Mongoid Configuration given the folder from where the application
      # is loaded, and the type of job requiring it (specs or a service basically)
      module Mongoid
        # Gets the root folder of the job loading Mongoid, and infers the filename from it.
        # if it's a simple service, it's in ./config, if it's specs, it's in ../config
        #
        # @param test_job [Boolean] TRUE if the configuration is loaded from specs, FALSE
        #   if the configuration is loaded from the config.ru of a service.
        def load_mongoid!(test_job = false)
          env = test_job ? :test : environment
          Mongoid.load!(File.join(@location, 'config', 'mongoid.yml'), env)
        end

        private

        def environment
          ENV['RACK_ENV'].to_sym || :development
        end
      end
    end
  end
end
