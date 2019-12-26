# frozen_string_literal: true

module Virtuatable
  module Builders
    module Helpers
      # Loads the environment variables from the .env file at the project's root.
      # @author Vincent Courtois <courtois.vincent@outlook.com>
      module Environment
        extend ActiveSupport::Concern

        included do
          declare_loader(:environment, priority: 0)
        end

        # Loads the environment variables used in the application.
        def load_environment!
          loading = Dotenv.load(env_file, env_file(mode))
          puts loading
        end

        def env_file(name = '')
          puts "Chargement du fichier #{File.join(directory, "#{name}.env")}"
          File.join(directory, "#{name}.env")
        end
      end
    end
  end
end
