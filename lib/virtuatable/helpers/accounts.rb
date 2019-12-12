# frozen_string_literal: true

module Virtuatable
  module Helpers
    # These helpers provide methods used to get and check accounts.
    # @author Vincent Courtois <courtois.vincent@outlook.com>
    module Accounts

      # Raises a bad request error if the account if not found.
      # @raise [Virtuatable::API::Errors::BadRequest] the error raised when the account is not found.
      def account
        account = (!respond_to?(:session) || session.nil?) ? nil : session.account
        api_bad_request 'session_id.required' if account.nil?

        account
      end
    end
  end
end
