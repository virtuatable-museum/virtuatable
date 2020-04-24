# frozen_string_literal: true
require 'require_all'

# Main module of the application, containing each other one.
# @author Vincent Courtois <courtois.vincent@outlook.com>
module Virtuatable
  autoload :API, 'virtuatable/api'
  autoload :Application, 'virtuatable/application'
  autoload :Builders, 'virtuatable/builders'
  autoload :Controllers, 'virtuatable/controllers'
  autoload :Enhancers, 'virtuatable/enhancers'
  autoload :Helpers, 'virtuatable/helpers'
  autoload :Loader, 'virtuatable/application'
end
