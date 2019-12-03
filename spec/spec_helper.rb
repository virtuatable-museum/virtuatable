require 'simplecov'
SimpleCov.start do
  add_filter File.join('spec', '*')
end

require 'sinatra'
require 'arkaan'
require 'mongoid'
require 'bundler'
require 'virtuatable'

Bundler.require(:development)

ENV['SERVICE_URL'] = 'https://localhost:9292/'
ENV['INSTANCE_TYPE'] = 'unix'

Virtuatable::Application.load_tests!('tests')

require_rel 'support/**/*.rb'
require_rel 'classes/**/*.rb'