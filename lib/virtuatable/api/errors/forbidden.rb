# frozen_string_literal: true

module Virtuatable
  module API
    module Errors
      # A forbidden error occurs when a user tries to perform an action he's not allowed to.
      # @author Vincent Courtois <courtois.vincent@outlook.com>
      class Forbidden < Virtuatable::API::Errors::Base
        def initialize(field:, error:)
          super(field: field, error: error, status: 403)
        end
      end
    end
  end
end
