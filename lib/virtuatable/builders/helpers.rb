# frozen_string_literal: true

module Virtuatable
  module Builders
    # These helpers are used when loading the application.
    # @author Vincent Courtois <courtois.vincent@outlook.com>
    module Helpers
      autoload :Controllers, 'virtuatable/builders/helpers/controllers'
      autoload :Environment, 'virtuatable/builders/helpers/environment'
      autoload :Loaders, 'virtuatable/builders/helpers/loaders'
      autoload :Mongoid, 'virtuatable/builders/helpers/mongoid'
    end
  end
end
