RSpec.describe Virtuatable::Helpers::Gateways do
  let!(:gateway) { create(:gateway) }

  describe 'When the gateway exists and the token is given' do
    let!(:klass) {
      Class.new do
        include Virtuatable::Helpers::Gateways

        def params
          {'token' => 'gateway_token'}
        end
      end
    }
    it 'Correctly returns the gateway with the getter' do
      expect(klass.new.gateway.id).to eq gateway.id
    end
    it 'Does not raise an error with the checker' do
      expect(klass.new.gateway!.id).to eq gateway.id
    end
  end
  describe 'When the given token is not linked to any gateway' do
    let!(:klass) {
      Class.new do
        include Virtuatable::Helpers::Gateways

        def params
          {'token' => 'unknown_token'}
        end
      end
    }
    it 'Correctly returns nil with the getter' do
      expect(klass.new.gateway).to be nil
    end
    it 'Raises the correct error with the checker' do
      expect(->{ klass.new.gateway! }).to raise_error(Virtuatable::API::Errors::NotFound)
    end
  end
  describe 'When the token is not given' do
    let!(:klass) {
      Class.new do
        include Virtuatable::Helpers::Gateways

        def params; {}; end
      end
    }
    it 'Correctly returns nil with the getter' do
      expect(klass.new.gateway).to be nil
    end
    it 'Raises the correct error with the checker' do
      expect(->{ klass.new.gateway! }).to raise_error(Virtuatable::API::Errors::BadRequest)
    end
  end
end