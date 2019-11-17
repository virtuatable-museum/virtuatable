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
        unless params.key?('token')
          raise Virtuatable::API::Errors::BadRequest.new(
            field: 'gateway_token',
            error: 'required'
          )
        end
        if gateway.nil?
          raise Virtuatable::API::Errors::NotFound.new(
            field: 'gateway_token',
            error: 'unknown'
          )
        end
        
        gateway
      end
    end
  end
end