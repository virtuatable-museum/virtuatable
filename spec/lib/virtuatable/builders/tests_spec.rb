RSpec.describe Virtuatable::Builders::Tests do
  let!(:builder) { Virtuatable::Builders::Tests.new(name: 'specs', path: '../../..') }
  let!(:path) { File.absolute_path(File.join(__dir__, '..', '..', '..')) }
  let!(:mongoid_path) { File.join(path, 'config', 'mongoid.yml') }

  describe :directory do
    it 'Returns the correct directory' do
      expected = File.absolute_path(File.join(__dir__, '..', '..', '..'))
      expect(builder.directory).to eq expected
    end
  end

  describe :load_tests! do
    it 'Requires the correct folders overall' do
      allow(File).to receive(:directory?).and_return(true)
      paths = ['spec/support', 'spec/shared']
      paths.each do |end_path|
        complete_path = File.join(path, end_path)
        expect(builder).to receive(:require_all).with(complete_path).and_return(false)
      end
      builder.load_tests!
    end
  end

  describe :load! do
    before do
      stub_const('ENV', {
        'SERVICE_URL' => 'http://localhost:9292',
        'INSTANCE_TYPE' => 'unix'
      })
      # We mock the require_all because the folders does not exist, and this
      # feature is tested in the load_folders tests where we check the paths.
      allow(builder).to receive(:require_all).and_return(false)
    end
    it 'Has correctly called the Mongoid loader' do
      expect(Mongoid).to receive(:load!).and_return false
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
    it 'Has correctly called the tests loader' do
      expect(builder).to receive(:load_tests!).and_return(false)
      builder.load!
    end
  end
end