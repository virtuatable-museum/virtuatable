module Virtuatable
  # The enhancers are the equivalent of a decorator.
  # It provides a simple system to add features to a class
  # without reopening or altering the said class.
  #
  # @author Vincent Courtois <courtois.vincent@outlook.com>
  module Enhancers
    autoload :Base, 'virtuatable/enhancers/base'
    autoload :Helpers, 'virtuatable/enhancers/helpers'
  end
end