RSpec.describe Virtuatable::Helpers::Accounts do
  let!(:babausse) { create(:babausse) }
  let!(:session) { create(:session, account: babausse) }

  describe 'When both helpers are included' do
    describe 'When the session and the account both exist' do
      let!(:klass) {
        Class.new do
          include Virtuatable::Helpers::Accounts
          include Virtuatable::Helpers::Sessions

          def params
            {'session_id' => 'session_token'}
          end
        end
      }
      it 'Correctly returns the account' do
        expect(klass.new.account.id).to eq babausse.id
      end
      it 'Correctly returns the account for the session' do
        expect(klass.new.account_for(session).id).to eq babausse.id
      end
    end
    describe 'When the session does not exist' do
      let!(:klass) {
        Class.new do
          include Virtuatable::Helpers::Accounts
          include Virtuatable::Helpers::Sessions

          def params
            {'session_id' => 'unknown_token'}
          end
        end
      }
      it 'Correctly returns nil for the account' do
        expect(klass.new.account).to be nil
      end
    end
    describe 'When the session ID is not given' do
      let!(:klass) {
        Class.new do
          include Virtuatable::Helpers::Accounts
          include Virtuatable::Helpers::Sessions

          def params; {}; end
        end
      }
      it 'Correctly returns nil for the account' do
        expect(klass.new.account).to be nil
      end
    end
  end

  describe 'When the session helper is NOT included' do
    describe 'When the session and the account both exist' do
      let!(:klass) {
        Class.new do
          include Virtuatable::Helpers::Accounts

          def params
            {'session_id' => 'session_token'}
          end
        end
      }
      it 'Correctly returns the account' do
        expect(klass.new.account.id).to eq babausse.id
      end
      it 'Correctly returns the account for the session' do
        expect(klass.new.account_for(session).id).to eq babausse.id
      end
    end
    describe 'When the session does not exist' do
      let!(:klass) {
        Class.new do
          include Virtuatable::Helpers::Accounts

          def params
            {'session_id' => 'unknown_token'}
          end
        end
      }
      it 'Correctly returns nil for the account' do
        expect(klass.new.account).to be nil
      end
    end
    describe 'When the session ID is not given' do
      let!(:klass) {
        Class.new do
          include Virtuatable::Helpers::Accounts

          def params; {}; end
        end
      }
      it 'Correctly returns nil for the account' do
        expect(klass.new.account).to be nil
      end
    end
  end
end