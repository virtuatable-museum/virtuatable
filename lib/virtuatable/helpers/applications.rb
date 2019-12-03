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
        check_presence 'app_key'
        api_not_found 'app_key.unknown' if application.nil?
        api_forbidden 'app_key.forbidden' if premium && !application.premium

        application
      end
    end
  end
end
