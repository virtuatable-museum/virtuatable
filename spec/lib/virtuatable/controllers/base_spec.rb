RSpec.describe Virtuatable::Controllers::Base do

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

  describe 'API routes' do
    let!(:klass) {
      Class.new(Virtuatable::Controllers::Base) do
        api_route 'GET', '/path', options: {premium: true}
      end
    }
    describe 'Non premium apps requesting a premium route' do
      def app
        klass.new
      end
      let!(:babausse) { create(:babausse) }
      let!(:application) { create(:application, creator: babausse) }
      before do
        get '/tests/path', {app_key: application.key}
      end
      it 'Has returned a Forbidden (403) status code' do
        expect(last_response.status).to be 403
      end
      it 'Has returned the correct body' do
        expect(last_response.body).to include_json(
          status: 403,
          field: 'app_key',
          error: 'forbidden'
        )
      end
    end
  end
end