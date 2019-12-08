# frozen_string_literal: true

module Virtuatable
  module Controllers
    # This class represents a base controller for the system, giving access
    # to checking methods for sessions, gateways, applications, etc.
    # @author Vincent Courtois <courtois.vincent@outlook.com>
    class Base < Sinatra::Base
      register Sinatra::ConfigFile
      helpers Sinatra::CustomLogger
      # Includes the custom errors throwers and responses helpers.
      include Virtuatable::API::Errors
      include Virtuatable::API::Responses
      # Includes the checking methods for sessions.
      include Virtuatable::Helpers::Sessions
      # Include the checkers and getters for the API gateway.
      include Virtuatable::Helpers::Gateways
      # Include the checkers and getters for OAuth apps
      include Virtuatable::Helpers::Applications
      # Include checkers for field requirement and check
      include Virtuatable::Helpers::Fields
      # Include the getter for the currently requested route.
      include Virtuatable::Helpers::Routes
      # Include the getter and checkers for accounts.
      include Virtuatable::Helpers::Accounts
      # Include the loading of the parameters from the JSON body
      include Virtuatable::Helpers::Parameters
      # This module is extended, not included, because it provides routes
      # declaration methods used in class declarations.
      extend Virtuatable::Helpers::Declarators

      configure do
        set :logger, Logger.new(STDOUT)
        logger.level = Logger::ERROR if ENV['RACK_ENV'] == 'test'
        # This configuration options allow the error handler to work in tests.
        set :show_exceptions, false
        set :raise_errors, false
      end

      error Mongoid::Errors::Validations do |errors|
        api_bad_request errors.document.errors.messages.keys.first
      end

      error Virtuatable::API::Errors::NotFound do |exception|
        api_not_found exception.message
      end

      error Virtuatable::API::Errors::BadRequest do |exception|
        api_bad_request exception.message
      end

      error Virtuatable::API::Errors::Forbidden do |exception|
        api_forbidden exception.message
      end

      if ENV['RACK_ENV'] != 'test'
        error StandardError do |error|
          api_error 500, "unknown_field.#{error.class.name}"
        end
      end
    end
  end
end
