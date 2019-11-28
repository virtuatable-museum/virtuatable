RSpec.describe Virtuatable::Builders::Tests do
  let!(:builder) { Virtuatable::Builders::Tests.new(name: 'specs') }

  describe :directory do
    it 'Returns the correct directory' do
      expected = File.absolute_path(File.join(__dir__, '..'))
      expect(builder.directory).to eq expected
    end
  end
end