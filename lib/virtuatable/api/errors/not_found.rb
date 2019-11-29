# frozen_string_literal: true

module Virtuatable
  module API
    module Errors
      # A not found error occurs when a user tries to reach a resource that does not exist.
      # @author Vincent Courtois <courtois.vincent@outlook.com>
      class NotFound < Virtuatable::API::Errors::Base
        def initialize(field:, error:)
          super(field: field, error: error, status: 404)
        end
      end
    end
  end
end
