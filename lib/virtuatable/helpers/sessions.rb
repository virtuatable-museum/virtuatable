# frozen_string_literal: true

module Virtuatable
  module Helpers
    # This helper gives access to methods about user's session on the API.
    # @author Vincent Courtois <courtois.vincent@outlook.com>
    module Sessions

      # Checks the session of the user requesting the API and returns an error
      # if it either not exists with the given token, or the token is not given.
      #
      # @raise [Virtuatable::API::Errors::NotFound] if the session is not found
      #   or the token not given in the parameters of the request.
      # @raise [Virtuatable::API::Errors::BadRequest] if the session token is
      #   not correctly given in the parameters.
      #
      # @return [Arkaan::Authentication::Session] the current session of the user.
      def session
        check_presence 'session_id'
        session = Arkaan::Authentication::Session.find_by(token: params['session_id'])
        api_not_found 'session_id.unknown' if session.nil?

        session
      end
    end
  end
end
