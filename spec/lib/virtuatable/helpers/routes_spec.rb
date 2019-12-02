RSpec.describe Virtuatable::Helpers::Routes do
  before do
    stub_const('ENV', {
      'SERVICE_URL' => 'https://localhost:9292/',
      'INSTANCE_TYPE' => 'unix'
    })
  end
  describe 'When creating a route' do
    let!(:builder) { Virtuatable::Application.load!('routes', path: '../../../..') }
    before do
      builder.load!
    end
    describe :api_route do
      describe 'When adding a route for the first time' do
        let!(:klass) {
          Class.new do
            extend Virtuatable::Helpers::Routes

            api_route 'GET', '/path', options: {premium: true, authenticated: true}
          end
        }
        let!(:route) { klass.routes.first }

        it 'Creates a route with the correct path' do
          expect(route.path).to eq '/routes/path'
        end
        it 'Creates a route with the correct verb' do
          expect(route.verb).to eq 'get'
        end
        it 'Creates a route with the correct authenticated flag' do
          expect(route.premium).to be true
        end
        it 'Creates a route with the correct premium flag' do
          expect(route.authenticated).to be true
        end
      end
      describe 'Options default values' do
        let!(:klass) {
          Class.new do
            extend Virtuatable::Helpers::Routes

            api_route 'GET', '/path'
          end
        }
        let!(:route) { klass.routes.first }
        it 'Has the correct value for the authenticated flag' do
          expect(route.authenticated).to be true
        end
        it 'Has the correct value for the premium flag' do
          expect(route.premium).to be false
        end
      end
      describe 'When adding the same route twice' do
        let!(:klass) {
          Class.new do
            extend Virtuatable::Helpers::Routes

            api_route 'GET', '/path'
            api_route 'GET', '/path'
          end
        }
        it 'has only created one route' do
          expect(Arkaan::Monitoring::Route.count).to be 1
        end
        it 'has only stored one route in the routes array' do
          expect(klass.routes.count).to be 1
        end
      end
    end
  end
end