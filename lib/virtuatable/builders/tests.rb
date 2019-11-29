module Virtuatable
  module Builders
    class Tests < Virtuatable::Builders::Base
      include Virtuatable::Builders::Helpers::Tests

      def initialize(path: '..', name:)
        super(locations: caller_locations, path: path, name: name)
        @mode = :test
      end
    end
  end
end