# frozen_string_literal: true

module Virtuatable
  module Enhancers
    # Helpers hold the secondary modules extended or included in the base enhancer.
    # @author Vincent Courtois <courtois.vincent@outlook.com>
    module Helpers
      autoload :Declarations, 'virtuatable/enhancers/helpers/declarations'
    end
  end
end
