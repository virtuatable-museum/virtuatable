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
  spec.homepage    = 'https://rubygems.org/gems/arkaan'
  spec.license     = 'MIT'

  spec.add_development_dependency 'rspec'                  , '3.6.0'
  spec.add_development_dependency 'rspec-json_expectations', '2.1.0'
  spec.add_development_dependency 'rack-test'              , '0.7.0'
  spec.add_development_dependency 'factory_bot'            , '5.1.1'
  spec.add_development_dependency 'database_cleaner'       , '1.7.0'
  spec.add_development_dependency 'simplecov'              , '0.15.1'
  spec.add_development_dependency 'yard'                   , '0.9.20'
  spec.add_development_dependency 'pry'                    , '0.11.1'
  spec.add_development_dependency 'rack'                   , '2.0.7'
  spec.add_development_dependency 'require_all'            , '3.0.0'

  spec.add_runtime_dependency 'mongoid'        , '7.0.1'
  spec.add_runtime_dependency 'activemodel'    , '5.2.3'
  spec.add_runtime_dependency 'activesupport'  , '5.2.3'
  spec.add_runtime_dependency 'bcrypt'         , '3.1.11'
  spec.add_runtime_dependency 'sinatra'        , '2.0.5'
  spec.add_runtime_dependency 'sinatra-contrib', '2.0.5'
  spec.add_runtime_dependency 'platform-api'   , '2.1.0'
  spec.add_runtime_dependency 'faraday'        , '0.15.2'
  spec.add_runtime_dependency 'draper'         , '3.1.0'
  spec.add_runtime_dependency 'actionview'     , '5.2.3'
  spec.add_runtime_dependency 'dotenv'         , '2.7.2'
  spec.add_runtime_dependency 'require_all'    , '3.0.0'
end