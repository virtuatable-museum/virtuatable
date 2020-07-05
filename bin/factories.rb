module Factories
  autoload :Git, File.join(__dir__, 'factories', 'git.rb')
  autoload :Kubernetes, File.join(__dir__, 'factories', 'kubernetes.rb')
  autoload :Versions, File.join(__dir__, 'factories', 'versions.rb')
end