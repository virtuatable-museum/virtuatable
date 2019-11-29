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

require_rel 'support/**/*.rb'
require_rel 'classes/**/*.rb'