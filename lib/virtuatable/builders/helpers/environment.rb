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

        def load_environment!
          Dotenv.load('.env', "#{mode}.env")
        end
      end
    end
  end
end
