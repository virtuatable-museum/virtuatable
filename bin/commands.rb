module Commands
  autoload :Docker, File.join(__dir__, 'commands', 'docker.rb')
  autoload :Kube, File.join(__dir__, 'commands', 'kube.rb')
end