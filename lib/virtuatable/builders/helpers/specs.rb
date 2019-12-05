# frozen_string_literal: true

module Virtuatable
  module Builders
    module Helpers
      # This module holds all the logic for the specs tools for all micro services (shared examples and other things).
      # @author Vincent Courtois <courtois.vincent@outlook.com>
      module Specs
        extend ActiveSupport::Concern

        included do
          declare_loader(:specs, priority: 5)
        end
      
        # Includes all the shared examples you could need, describing the basic behaviour of a route.
        def load_specs!
          unless @declared == true
            RSpec.shared_examples 'a route' do |_verb, _path, _options = {}|
              let(:verb) { _verb.to_sym }
              let(:path) { _path }

              let!(:account) {
                Arkaan::Account.create(
                  username: 'Shared examples user',
                  email: 'shared@examples.com',
                  password: 'password',
                  password_confirmation: 'password',
                  firstname: 'Shared',
                  lastname: 'Examples'
                )
              }

              let!(:gateway) {
                Arkaan::Monitoring::Gateway.create(
                  url: 'https://localhost:9000/',
                  running: true,
                  active: true,
                  token: 'shared examples gateway token'
                )
              }

              let!(:appli) {
                Arkaan::OAuth::Application.create(
                  name: 'shared examples application',
                  creator: account,
                  premium: false
                )
              }

              let!(:session) {
                Arkaan::Authentication::Session.create(
                  token: 'shared example session token',
                  account: account
                )
              }
          
              describe 'common errors' do
                describe 'bad request errors' do
                  describe 'no token error' do
                    before do
                      public_send verb, path, {
                        app_key: appli.key,
                        session_id: session.token
                      }
                    end
                    it 'Raises a bad request (400) error when the parameters don\'t contain the token of the gateway' do
                      expect(last_response.status).to be 400
                    end
                    it 'returns the correct response if the parameters do not contain a gateway token' do
                      expect(last_response.body).to include_json(
                        status: 400,
                        field: 'token',
                        error: 'required'
                      )
                    end
                  end
                  describe 'no application key error' do
                    before do
                      public_send verb, path, {
                        token: gateway.token,
                        session_id: session.token
                      }
                    end
                    it 'Raises a bad request (400) error when the parameters don\'t contain the application key' do
                      expect(last_response.status).to be 400
                    end
                    it 'returns the correct response if the parameters do not contain a gateway token' do
                      expect(last_response.body).to include_json(
                        status: 400,
                        field: 'app_key',
                        error: 'required'
                      )
                    end
                  end
                  if _options[:authenticated] == true
                    describe 'no session token error' do
                      before do
                        public_send verb, path, {
                          app_key: appli.key,
                          token: gateway.token
                        }
                      end
                      it 'Raises a bad request (400) error when the parameters don\'t contain the session token' do
                        expect(last_response.status).to be 400
                      end
                      it 'returns the correct response if the parameters do not contain a session token' do
                        expect(last_response.body).to include_json(
                          status: 400,
                          field: 'session_id',
                          error: 'required'
                        )
                      end
                    end
                  end
                end
                describe 'not_found errors' do
                  describe 'application not found' do
                    before do
                      public_send verb, path, {
                        token: gateway.token,
                        session_id: session.token,
                        app_key: 'invalid application key'
                      }
                    end
                    it 'Raises a not found (404) error when the key doesn\'t belong to any application' do
                      expect(last_response.status).to be 404
                    end
                    it 'returns the correct response if the parameters do not contain a gateway token' do
                      expect(last_response.body).to include_json(
                        status: 404,
                        field: 'app_key',
                        error: 'unknown'
                      )
                    end
                  end
                  describe 'gateway not found' do
                    before do
                      public_send verb, path, {
                        token: 'invalid session token',
                        session_id: session.token,
                        app_key: appli.key
                      }
                    end
                    it 'Raises a not found (404) error when the gateway does\'nt exist' do
                      expect(last_response.status).to be 404
                    end
                    it 'returns the correct body when the gateway doesn\'t exist' do
                      expect(last_response.body).to include_json(
                        status: 404,
                        field: 'token',
                        error: 'unknown'
                      )
                    end
                  end
                  if _options[:authenticated] == true
                    describe 'session not found' do
                      before do
                        public_send verb, path, {
                          token: gateway.token,
                          session_id: 'invalid session token',
                          app_key: appli.key
                        }
                      end
                      it 'Raises a not found (404) error when the gateway does\'nt exist' do
                        expect(last_response.status).to be 404
                      end
                      it 'returns the correct body when the gateway doesn\'t exist' do
                        expect(last_response.body).to include_json(
                          status: 404,
                          field: 'session_id',
                          error: 'unknown'
                        )
                      end
                    end
                  end
                end
              end
            end
            @declared = true
          end
        end
      end
    end
  end
end