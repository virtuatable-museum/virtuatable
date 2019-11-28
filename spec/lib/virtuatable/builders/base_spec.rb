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

  describe :load_environment! do
    it 'Correctly calls for dotenv to load the environment' do
      expect(Dotenv).to receive(:load).and_return(false)
      builder.load_environment!
    end
  end

  describe :load_mongoid! do
    let!(:path) { File.absolute_path(File.join(__dir__, 'config', 'mongoid.yml')) }

    it 'correctly builds the path and mode to load mongoid' do
      expect(Mongoid).to receive(:load!).with(path, :development).and_return false
      builder.load_mongoid!
    end
  end
end