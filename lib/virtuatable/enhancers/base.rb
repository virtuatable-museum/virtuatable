# frozen_string_literal: true

module Virtuatable
  module Enhancers
    # Base class to be extended by all enhancers. It provides a way to declare
    # this class as the enhancer of another class, to access the properties
    # of the enhanced class as instance attributes.
    #
    # @author Vincent Courtois <courtois.vincent@outlook.com>
    class Base
      extend Virtuatable::Enhancers::Helpers::Declarations

      # @!attribute [r] object
      #   @return [Object] the enhanced object.
      attr_reader :object

      def initialize(object)
        @object = object
      end

      def method_missing(name, *args, &block)
        return object.send(name, *args, &block) if object.respond_to? name

        super
      end

      def respond_to_missing?(name, _include_private = false)
        object.respond_to? name
      end
    end
  end
end
