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
        raise_required! unless params.key?('token')
        raise_unknown! if gateway.nil?

        gateway
      end

      private

      def raise_required!
        raise Virtuatable::API::Errors::BadRequest.new(
          field: 'gateway_token',
          error: 'required'
        )
      end

      def raise_unknown!
        raise Virtuatable::API::Errors::NotFound.new(
          field: 'gateway_token',
          error: 'unknown'
        )
      end
    end
  end
end
