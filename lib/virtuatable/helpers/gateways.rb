# frozen_string_literal: true

module Virtuatable
  module Helpers
    # These helpers holds getters and checkers about API gateways.
    # @author Vincent Courtois <courtois.vincent@outlook.com>
    module Gateways
      # Gets the gateway associated to the gatexway token in parameters.
      # @return [Arkaan::Monitoring::Gateway] the gateway requesting the service
      def gateway
        Arkaan::Monitoring::Gateway.where(token: params['token']).first
      end

      # Checks the gateway requesting the service and raises an error if necessary.
      def gateway!
        check_presence 'token'
        api_not_found 'token.unknown' if gateway.nil?

        gateway
      end
    end
  end
end
