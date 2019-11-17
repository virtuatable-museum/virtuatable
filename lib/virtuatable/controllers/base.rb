module Virtuatable
  module Controllers
    # This class represents a base controller for the system, giving access
    # to checking methods for sessions, gateways, applications, etc.
    # @author Vincent Courtois <courtois.vincent@outlook.com>
    class Base < Sinatra::Base
      # Includes the custom errors throwers.
      include Virtuatable::API::Errors
      # Includes the checking methods for sessions.
      include Virtuatable::Helpers::Sessions

      configure do
        # This configuration options allow the error handler to work in tests.
        set :show_exceptions, false
        set :raise_errors, false
      end

      error Mongoid::Errors::Validations do |errors|
        api_bad_request errors.messages.keys.first
      end

      error Virtuatable::API::Errors::NotFound do |exception|
        api_not_found exception.message
      end
    end
  end
end