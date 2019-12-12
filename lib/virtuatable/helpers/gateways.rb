# frozen_string_literal: true

module Virtuatable
  module Helpers
    # These helpers holds getters and checkers about API gateways.
    # @author Vincent Courtois <courtois.vincent@outlook.com>
    module Gateways
      # Checks the gateway requesting the service and raises an error if necessary.
      # @return [Arkaan::Monitoring::Gateway] the current gateway requesting the service.
      def gateway
        return @gateway unless @gateway.nil?

        check_presence 'token'
        @gateway = Arkaan::Monitoring::Gateway.find_by(token: params['token'])
        @gateway.nil? ? api_not_found('token.unknown') : @gateway
      end
    end
  end
end
