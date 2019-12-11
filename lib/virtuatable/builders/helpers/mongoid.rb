# frozen_string_literal: true

module Virtuatable
  module Builders
    module Helpers
      # Loads the Mongoid Configuration given the folder from where the application
      # is loaded, and the type of job requiring it (specs or a service basically)
      module Mongoid
        extend ActiveSupport::Concern

        included do
          declare_loader(:mongoid, priority: 1)
        end

        # Loads Mongoid configuration file from the standard path.
        def load_mongoid!
          filepath = File.join(@directory, 'config', 'mongoid.yml')
          ::Mongoid.load!(filepath, @mode)
          ::Mongoid.raise_not_found_error = false
        end
      end
    end
  end
end
