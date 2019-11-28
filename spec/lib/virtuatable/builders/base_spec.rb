RSpec.describe Virtuatable::Builders::Base do
  let!(:builder) { Virtuatable::Builders::Base.new }

  describe :directory do
    it 'Returns the correct directory' do
      expect(builder.directory).to eq File.absolute_path(__dir__)
    end
  end

  describe :loaders do
    it 'Contains the Mongoid loader' do
      expect(Virtuatable::Builders::Base.loaders).to include :mongoid
    end
    it 'Contains the environment loader' do
      expect(Virtuatable::Builders::Base.loaders).to include :environment
    end
  end
end