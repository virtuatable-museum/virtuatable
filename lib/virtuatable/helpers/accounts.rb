# frozen_string_literal: true

module Virtuatable
  module Helpers
    # These helpers provide methods used to get and check accounts.
    # @author Vincent Courtois <courtois.vincent@outlook.com>
    module Accounts
      # Gets the account linked to the current session.
      # @return [Arkaan::Account] the account linked to the current session.
      def account
        !respond_to?(:session) || session.nil? ? nil : session.account
      end

      def account!
        api_bad_request 'session_id.required' if account.nil?
      end
    end
  end
end
