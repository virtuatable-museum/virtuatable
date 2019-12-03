RSpec.describe Virtuatable::Application do
  describe :load! do
    before do
      Virtuatable::Application.load!('tests', path: '../../..')
    end
    it 'has loaded the correct type of application' do
      expect(Virtuatable::Application.builder).to be_a_kind_of(Virtuatable::Builders::Base)
    end
  end
  describe :load_tests! do
    before do
      Virtuatable::Application.load_tests!('tests', path: '../../..')
    end
    it 'has loaded the correct type of application' do
      expect(Virtuatable::Application.builder).to be_a_kind_of(Virtuatable::Builders::Tests)
    end
  end
end