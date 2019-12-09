# frozen_string_literal: true

module Virtuatable
  module Helpers
    # Helpers to correctly build the parameters hash, even from the JSON body.
    # @author Vincent Courtois <courtois.vincent@outlook.com>
    module Parameters
      # Returns the parameters depending on whether the request has a body
      # or not. If it has a body, it parses it, otherwise it just returns the params.
      # @return [Hash] the parameters sent with the request.
      def parameters
        params.merge(body_params)
      end

      # The parameters from the JSON body if it is sent.
      # @return [Hash] the JSON body parsed as a dictionary.
      def body_params
        request.body.rewind
        JSON.parse(request.body.read.to_s)
      rescue JSON::ParserError
        {}
      end
    end
  end
end
