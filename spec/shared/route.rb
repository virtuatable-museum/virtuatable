RSpec.shared_examples 'a controller' do |prefix, verb|
  let!(:klass) {
    Class.new(Virtuatable::Controllers::Base) do
      api_route verb, '/authenticated', options: {
        authenticated: true,
        premium: false
      } do; end
      api_route verb, '/premium', options: {
        authenticated: false,
        premium: true
      } do; end
    end
  }

  def app
    klass.new
  end

  let!(:babausse) { create(:babausse) }
  let!(:gateway) { create(:gateway) }
  let!(:session) { create(:session, account: babausse) }
  let!(:application) { create(:application, creator: babausse) }
  let!(:premium_app) { create(:premium_app, creator: babausse) }

  describe 'When a non-premium app tries to access a premium route' do
    before do
      send(verb, "/#{prefix}/premium", {
        gateway: gateway.token,
        app_key: application.key,
        session_id: session.token
      })
    end
    it 'Returns a 403 (Forbidden) status code' do
      expect(last_response.status).to be 403
    end
    it 'Returns the correct body' do
      expect(last_response.body).to include_json(
        status: 403,
        field: 'app_key',
        error: 'forbidden'
      )
    end
  end
  describe 'When a non-authenticated request is made on an authenticated route' do
    before do
      send(verb, "/#{prefix}/authenticated", {
        token: gateway.token,
        app_key: application.key
      })
    end
    it 'Returns a 400 (Bad Request) status code' do
      expect(last_response.status).to be 400
    end
    it 'Returns the correct body' do
      expect(last_response.body).to include_json(
        status: 400,
        field: 'session_id',
        error: 'required'
      )
    end
  end
end