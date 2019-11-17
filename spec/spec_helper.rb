require 'sinatra'
require 'arkaan'
require 'mongoid'
require 'bundler'
require 'virtuatable'

Bundler.require(:development)

require_rel 'support/**/*.rb'
require_rel 'classes/**/*.rb'