RSpec.describe Virtuatable::Helpers::Fields do
  describe 'When a required field is not present' do
    let!(:klass) {
      Class.new do
        include Virtuatable::Helpers::Fields

        def params; {}; end
      end
    }
    it 'Raises an error when the required field is not here' do
      expect(->{ klass.new.check_presence('test') }).to raise_error(Virtuatable::API::Errors::BadRequest)
    end
  end
  describe 'When a required field is present' do
    let!(:klass) {
      Class.new do
        include Virtuatable::Helpers::Fields

        def params
          {'test' => 'value'}
        end
      end
    }
    it 'Does not raise an error when checking the field' do
      expect(->{ klass.new.check_presence('test') }).to_not raise_error
    end
  end
  describe 'When either of the needed fields is present' do
    let!(:klass) {
      Class.new do
        include Virtuatable::Helpers::Fields

        def params
          {'test' => 'value'}
        end
      end
    }
    it 'Does not raise an error if either field is present' do
      expect(->{ klass.new.check_either_presence('test', 'foo', 'bar', key: 'test') }).to_not raise_error
    end
  end
  describe 'When none of the needed fields is present' do
    let!(:klass) {
      Class.new do
        include Virtuatable::Helpers::Fields

        def params
          {'test' => 'value'}
        end
      end
    }
    it 'Raises an error if no field is present' do
      expect(-> { klass.new.check_either_presence('foo', 'bar', key: 'test') }).to raise_error(Virtuatable::API::Errors::BadRequest)
    end
  end
end