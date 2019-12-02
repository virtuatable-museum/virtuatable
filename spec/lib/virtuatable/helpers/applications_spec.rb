RSpec.describe Virtuatable::Helpers::Applications do
  let!(:babausse) { create(:babausse) }
  let!(:application) { create(:application, creator: babausse) }

  describe 'When the application exists and the key is given' do
    let!(:klass) {
      Class.new do
        include Virtuatable::Helpers::Applications

        def params
          {'app_key' => 'application_key'}
        end
      end
    }
    it 'Correctly returns the application with the getter' do
      expect(klass.new.application.id).to eq application.id
    end
    it 'Does not raise an error with the checker' do
      expect(klass.new.application!.id).to eq application.id
    end
  end
  describe 'When the given key is not linked to any application' do
    let!(:klass) {
      Class.new do
        include Virtuatable::Helpers::Applications

        def params
          {'app_key' => 'unknown_key'}
        end
      end
    }
    it 'Correctly returns nil with the getter' do
      expect(klass.new.application).to be nil
    end
    it 'Raises the correct error with the checker' do
      expect(->{ klass.new.application! }).to raise_error(Virtuatable::API::Errors::NotFound)
    end
  end
  describe 'When the key is not given' do
    let!(:klass) {
      Class.new do
        include Virtuatable::Helpers::Applications

        def params; {}; end
      end
    }
    it 'Correctly returns nil with the getter' do
      expect(klass.new.application).to be nil
    end
    it 'Raises the correct error with the checker' do
      expect(->{ klass.new.application! }).to raise_error(Virtuatable::API::Errors::BadRequest)
    end
  end

  describe 'premium flag check' do
    describe 'When the application was supposed to be premium' do
      let!(:klass) {
        Class.new do
          include Virtuatable::Helpers::Applications

          def params
            {'app_key' => 'application_key'}
          end
        end
      }
      it 'correctly returns the application for the getter' do
        expect(klass.new.application.id).to eq application.id
      end
      it 'correctly raises an error with the checker' do
        expect(->{ klass.new.application!(premium: true) }).to raise_error(Virtuatable::API::Errors::Forbidden)
      end
    end

    describe 'When the application is premium' do
      let!(:application) { create(:premium_app, creator: babausse) }
      let!(:klass) {
        Class.new do
          include Virtuatable::Helpers::Applications

          def params
            {'app_key' => 'premium_key'}
          end
        end
      }
      it 'correctly returns the application with the getter' do
        expect(klass.new.application.id).to eq application.id
      end
      it 'correctly returns the application with the checker' do
        expect(->{ klass.new.application!(premium: true) }).to_not raise_error
      end
    end
  end
end