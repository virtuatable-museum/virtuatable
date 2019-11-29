module Virtuatable
  module Builders
    # Module holding the errors raised at the loading of the service
    # @author Vincent Courtois <courtois.vincent@outlook.com>
    module Errors
      autoload :MissingEnv, 'virtuatable/builders/errors/missing_env'
    end
  end
end