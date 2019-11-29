# frozen_string_literal: true

module Virtuatable
  # Builders are used to load all the needed elements in the application,
  # either from the config.ru as an app, or the spec_helper as tests.
  # @author Vincent Courtois <courtois.vincent@outlook.com>
  module Builders
    autoload :Base, 'virtuatable/builders/base'
    autoload :Errors, 'virtuatable/builders/errors'
    autoload :Helpers, 'virtuatable/builders/helpers'
    autoload :Tests, 'virtuatable/builders/tests'
  end
end
