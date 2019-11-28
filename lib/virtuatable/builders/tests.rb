module Virtuatable
  module Builders
    class Tests < Virtuatable::Builders::Base
      def initialize(path: '..')
        super(locations: caller_locations, path: path)
        @mode = :test
      end
    end
  end
end