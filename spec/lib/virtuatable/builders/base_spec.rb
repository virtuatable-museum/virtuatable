RSpec.describe Virtuatable::Builders::Base do
  let!(:builder) { Virtuatable::Builders::Base.new(name: 'specs', path: '../../../..') }
  let!(:path) { File.absolute_path(File.join(__dir__, '..', '..', '..', '..')) }
  let!(:mongoid_path) { File.join(path, 'config', 'mongoid.yml') }

  describe :directory do
    it 'Returns the correct directory' do
      expect(builder.directory).to eq path
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

  describe :load_registration! do
    before do
      builder.load_registration!
    end
    it 'Has created a service in the database' do
      expect(Arkaan::Monitoring::Service.count).to be 1
    end
    it 'Has created the service with the correct name' do
      expect(Arkaan::Monitoring::Service.first.key).to eq 'specs'
    end
    it 'Has created the service with the correct path' do
      expect(Arkaan::Monitoring::Service.first.path).to eq '/specs'
    end
  end

  describe :load! do
    
    it 'Has correctly called the Mongoid loader' do
      expect(Mongoid).to receive(:load!).with(mongoid_path, :development).and_return false
      builder.load!
    end
    it 'Has correctly called the environment loader' do
      expect(Dotenv).to receive(:load).and_return(false)
      builder.load!
    end
    it 'Has correctly called the registration loader' do
      expect(builder).to receive(:load_registration!).and_return(false)
      builder.load!
    end
  end
end