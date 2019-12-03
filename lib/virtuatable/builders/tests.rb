# frozen_string_literal: true

module Virtuatable
  module Builders
    # Builder used to declare an application from a spec/spec_helper file, loading everything
    # a normal loader requires, then adding the files specialized in tests.
    # @author Vincent Courtois <courtois.vincent@outlook.com>
    class Tests < Virtuatable::Builders::Base
      include Virtuatable::Builders::Helpers::Tests

      def initialize(path: '..', name:, locations: caller_locations)
        super(locations: locations, path: path, name: name)
        @mode = :test
      end
    end
  end
end
