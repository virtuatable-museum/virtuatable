# frozen_string_literal: true

module Virtuatable
  module Builders
    module Helpers
      # Loads the environment variables from the .env file at the project's root.
      # @author Vincent Courtois <courtois.vincent@outlook.com>
      module Environment
        def load_environment!
          Dotenv.load
        end
      end
    end
  end
end
