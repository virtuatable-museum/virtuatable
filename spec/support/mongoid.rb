puts '> Chargement du fichier de configuration de MongoDB'
Mongoid.load!(File.join(__dir__, '..', 'config', 'mongoid.yml'), :test)