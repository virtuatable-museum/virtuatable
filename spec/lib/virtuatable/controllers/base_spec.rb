RSpec.describe Virtuatable::Controllers::Base do
  before do
    Virtuatable::Application.load_tests!('controllers', path: '../../..')
  end

  describe 'Not Found errors' do
    def app
      Controllers::NotFound.new
    end
    describe 'raised with an exception' do
      before do
        get '/exception'
      end
      it 'Returns a 404 status code' do
        expect(last_response.status).to be 404
      end
      it 'Returns the correct body' do
        expect(last_response.body).to include_json({
          status: 404,
          field: 'field',
          error: 'unknown'
        })
      end
    end
    describe 'halted with the method' do
      before do
        get '/method'
      end
      it 'Returns a 404 status code' do
        expect(last_response.status).to be 404
      end
      it 'Returns the correct body' do
        expect(last_response.body).to include_json({
          status: 404,
          field: 'field',
          error: 'unknown'
        })
      end
    end
  end

  describe 'Forbidden errors' do
    def app
      Controllers::Forbidden.new
    end
    describe 'raised with an exception' do
      before do
        get '/exception'
      end
      it 'Returns a 403 status code' do
        expect(last_response.status).to be 403
      end
      it 'Returns the correct body' do
        expect(last_response.body).to include_json({
          status: 403,
          field: 'field',
          error: 'forbidden'
        })
      end
    end
    describe 'halted with the method' do
      before do
        get '/method'
      end
      it 'Returns a 403 status code' do
        expect(last_response.status).to be 403
      end
      it 'Returns the correct body' do
        expect(last_response.body).to include_json({
          status: 403,
          field: 'field',
          error: 'forbidden'
        })
      end
    end
  end

  describe 'Bad Request errors' do
    def app
      Controllers::BadRequest.new
    end
    describe 'raised with an exception' do
      before do
        get '/exception'
      end
      it 'Returns a 400 status code' do
        expect(last_response.status).to be 400
      end
      it 'Returns the correct body' do
        expect(last_response.body).to include_json({
          status: 400,
          field: 'field',
          error: 'required'
        })
      end
    end
    describe 'halted with the method' do
      before do
        get '/method'
      end
      it 'Returns a 400 status code' do
        expect(last_response.status).to be 400
      end
      it 'Returns the correct body' do
        expect(last_response.body).to include_json({
          status: 400,
          field: 'field',
          error: 'required'
        })
      end
    end
  end

  describe 'Mongoid errors' do
    def app
      Controllers::Mongoid.new
    end
    describe 'raised with an exception' do
      before do
        get '/exception'
      end
      it 'Returns a 400 status code' do
        expect(last_response.status).to be 400
      end
      it 'Returns the correct body' do
        expect(last_response.body).to include_json({
          status: 400,
          field: 'username',
          error: 'required'
        })
      end
    end
  end

  describe 'Standard errors' do
    def app
      Controllers::StandardError.new
    end
    describe 'raised with an exception' do
      before do
        stub_const('ENV', {'RACK_ENV' => 'development'})
        get '/exception'
      end
      it 'Returns a 500 status code' do
        expect(last_response.status).to be 500
      end
      it 'Returns the correct body' do
        expect(last_response.body).to include_json({
          status: 500,
          field: 'unknown_field',
          error: 'StandardError'
        })
      end
    end
  end

  describe 'accounts and sessions helpers' do
    def app
      Controllers::Accounts.new
    end
    describe 'Nominal case' do
      let!(:babausse) { create(:babausse) }
      let!(:session) { create(:session, account: babausse) }
      it 'should correctly return the account when asked' do
        get '/account', {session_id: session.token}
        expect(last_response.body).to include_json(id: babausse.id.to_s)
      end
      it 'should return the session' do
        get '/session', {session_id: session.token}
        expect(last_response. body).to include_json({id: session.id.to_s})
      end
    end
    describe 'When the account is required bu not given' do
      before do
        get '/exception'
      end
      it 'Returns a 404 (Not Found) status code' do
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

  describe 'API routes' do
    it_should_behave_like 'a controller', 'controllers', 'get'
  end
end