RSpec.describe Virtuatable::Builders::Base do
  let!(:builder) { Virtuatable::Builders::Base.new(name: 'specs', path: '../../../..') }
  let!(:path) { File.absolute_path(File.join(__dir__, '..', '..', '..', '..')) }
  let!(:mongoid_path) { File.join(path, 'config', 'mongoid.yml') }

  describe :controllers do
    it 'Returns an empty list if no controller is declared' do
      expect(builder.controllers).to eq []
    end
  end

  describe :directory do
    it 'Returns the correct directory' do
      expect(builder.directory).to eq path
    end
  end

  describe :loaders do
    it 'Contains the Mongoid loader' do
      expect(Virtuatable::Builders::Base.loaders).to include({name: :mongoid, priority: 1})
    end
    it 'Contains the environment loader' do
      expect(Virtuatable::Builders::Base.loaders).to include({name: :environment, priority: 0})
    end
  end

  describe :load_environment! do
    it 'Correctly calls for dotenv to load the environment' do
      expect(Dotenv).to receive(:load).and_return(false)
      builder.load_environment!
    end
  end

  describe :load_registration! do
    describe 'Nominal case' do
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
      it 'Has correctly set the service in the builder' do
        expect(builder.service.key).to eq 'specs'
      end
      describe 'If the service is loaded twice' do
        it 'Has not created another service' do
          builder.load_registration!
          expect(Arkaan::Monitoring::Service.count).to be 1
        end
      end
    end
    describe :errors do
      it 'Raises an error if the service cannot be created' do
        builder.name = 'test_-&'
        expect(->{ builder.load_registration! }).to raise_error(Mongoid::Errors::Validations)
      end
    end
  end

  describe :load_folders! do
    it 'Requires the desired folders' do
      allow(File).to receive(:directory?).and_return(true)
      paths = ['controllers', 'services', 'decorators']
      paths.each do |end_path|
        complete_path = File.join(path, end_path)
        expect(builder).to receive(:require_all).with(complete_path).and_return(false)
      end
      builder.load_folders!
    end
  end

  describe :load! do
    before do
      # We mock the require_all because the folders does not exist, and this
      # feature is tested in the load_folders tests where we check the paths.
      allow(builder).to receive(:require_all).and_return(false)
    end
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
    it 'Has correctly called the folders loader' do
      expect(builder).to receive(:load_folders!).and_return(false)
      builder.load!
    end
  end
end