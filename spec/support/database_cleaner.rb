puts '> Création des hooks de nettoyage de la base de données'
RSpec.configure do |config|
  config.after(:each) do
    DatabaseCleaner.clean
  end
  config.before(:each) do
    DatabaseCleaner.clean
  end
end