module Virtuatable
  module Helpers
    # These helpers provide methods used to get and check accounts.
    # @author Vincent Courtois <courtois.vincent@outlook.com>
    module Accounts

      # Gets the account linked to the current session.
      # @return [Arkaan::Account] the account linked to the current session.
      def account
        if respond_to?(:session)
          account_for(session)
        else
          account_for(Arkaan::Authentication::Session.where(token: params['session_id']).first)
        end
      end

      # Gets the account of a session if it exists, or nil if the session is nil.
      # @param [Arkaan::Authentication::Session] the session to extract the account from.
      # @return [Arkaan::Account] the extracted account.
      def account_for(session)
        session.nil? ? nil : session.account
      end
    end
  end
end