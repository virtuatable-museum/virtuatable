RSpec.describe Virtuatable::Controllers::Base do
  def app
    Controller.new
  end

  describe 'Not Found errors' do
    describe 'raised with an exception' do
      before do
        get '/not_found_exception'
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
        get '/not_found_method'
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
end