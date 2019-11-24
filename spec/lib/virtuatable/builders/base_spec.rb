RSpec.describe Virtuatable::Builders::Base do
  let!(:builder) { Virtuatable::Builders::Base.new }

  describe :directory do
    it 'Returns the correct directory' do
      expect(builder.directory).to eq File.absolute_path(__dir__)
    end
  end
end