# frozen_string_literal: true

module Virtuatable
  # The API module gathers all classes called inside a route, for
  # example the errors thrown from the routes as HTTP status.
  # @author Vincent Courtois <courtois.vincent@outlook.com>
  module API
    autoload :Errors, 'virtuatable/api/errors'
    autoload :Responses, 'virtuatable/api/responses'
  end
end
