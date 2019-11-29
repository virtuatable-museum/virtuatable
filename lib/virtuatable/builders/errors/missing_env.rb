module Virtuatable
  module Builders
    module Errors
      # This error is raised when a variable is missing.
      # @author Vincent Courtois <courtois.vincent@outlook.com>
      class MissingEnv < StandardError
        # @!attribute [r] variable
        #   @return [String] the nam:e of the missing variable.
        attr_reader :variable

        def initialize(variable:)
          @variable = variable
        end
      end
    end
  end
end