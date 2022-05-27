require 'date'
require './lib/virtuatable/version'

Gem::Specification.new do |spec|
  spec.name        = 'virtuatable'
  spec.version     = Virtuatable::VERSION
  spec.date        = Date.today.strftime('%Y-%m-%d')
  spec.summary     = 'All the utility classes for the Virtuatable services'
  spec.description = 'This gem holds controllers, errors, service delcarations, etc. for the Virtuatable services.'
  spec.authors     = ['Vincent Courtois']
  spec.email       = 'courtois.vincent@outlook.com'
  spec.files       = Dir['lib/**/*.rb']
  spec.homepage    = 'https://rubygems.org/gems/virtuatable'
  spec.license     = 'MIT'

  spec.add_development_dependency 'database_cleaner', '1.6.1'
  spec.add_development_dependency 'factory_bot', '6.1.0'
  spec.add_development_dependency 'pry', '0.13.1'
  spec.add_development_dependency 'rack', '2.2.3.1'
  spec.add_development_dependency 'rack-test', '1.1.0'
  spec.add_development_dependency 'require_all', '3.0.0'
  spec.add_development_dependency 'rspec', '3.9.0'
  spec.add_development_dependency 'rspec-json_expectations', '2.1.0'
  spec.add_development_dependency 'rubocop', '0.90.0'
  spec.add_development_dependency 'simplecov', '0.19.0'
  spec.add_development_dependency 'yard', '0.9.25'

  spec.add_runtime_dependency 'activesupport', '6.0.3.2'
  spec.add_runtime_dependency 'arkaan', '>=2.7.2'
  spec.add_runtime_dependency 'dotenv', '2.7.6'
  spec.add_runtime_dependency 'faraday', '1.0.1'
  spec.add_runtime_dependency 'mongoid', '7.1.0'
  spec.add_runtime_dependency 'require_all', '3.0.0'
  spec.add_runtime_dependency 'sinatra', '>=2.1.0'
  spec.add_runtime_dependency 'sinatra-contrib', '2.1.0'
end