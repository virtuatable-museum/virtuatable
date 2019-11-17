RSpec.describe Virtuatable::Helpers::Sessions do
  let!(:babausse) { create(:babausse) }
  let!(:session) { create(:session, account: babausse) }
  
  describe 'When the session exists, and the token is given' do
    let!(:klass) {
      Class.new do
        include Virtuatable::Helpers::Sessions

        def params
          {'session_id' => 'session_token'}
        end
      end
    }

    it 'correctly returns the session when asked' do
      expect(klass.new.session.id).to eq session.id
    end
    it 'correctly returns the session with the checking method too' do
      expect(klass.new.check_session.id).to eq session.id
    end
  end

  describe 'When the token is given, but the session does not exist' do
    let!(:klass) {
      Class.new do
        include Virtuatable::Helpers::Sessions

        def params
          {'session_id' => 'unknown_token'}
        end
      end
    }
    it 'does not returns the session, but nil instead' do
      expect(klass.new.session).to be nil
    end
    it 'raises the correct error with the checking method' do
      expect(->{ klass.new.check_session }).to raise_error(Virtuatable::API::Errors::NotFound)
    end
  end

  describe 'When the token is not given' do
    let!(:klass) {
      Class.new do
        include Virtuatable::Helpers::Sessions

        def params; {}; end
      end
    }
    it 'does not returns the session, but nil instead' do
      expect(klass.new.session).to be nil
    end
    it 'raises the correct error with the checking method' do
      expect(->{ klass.new.check_session }).to raise_error(Virtuatable::API::Errors::BadRequest)
    end
  end
end