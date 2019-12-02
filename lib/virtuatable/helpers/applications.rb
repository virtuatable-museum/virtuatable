# frozen_string_literal: true

module Virtuatable
  module Helpers
    # Helpers to get and check OAuth applications connecting the the application.
    # @author Vincent Courtois <courtois.vincent@outlook.com>
    module Applications
      def application
        Arkaan::OAuth::Application.where(key: params['app_key']).first
      end

      # Looks for the application sending the API's request, and raises error if not found.
      def application!(premium: false)
        raise_required! unless params.key?('app_key')
        raise_unknown! if application.nil?
        raise_forbidden! if premium && !application.premium

        application
      end

      private

      def raise_forbidden!
        raise Virtuatable::API::Errors::Forbidden.new(
          field: 'app_key',
          error: 'forbidden'
        )
      end

      def raise_required!
        raise Virtuatable::API::Errors::BadRequest.new(
          field: 'app_key',
          error: 'required'
        )
      end

      def raise_unknown!
        raise Virtuatable::API::Errors::NotFound.new(
          field: 'app_key',
          error: 'unknown'
        )
      end
    end
  end
end
