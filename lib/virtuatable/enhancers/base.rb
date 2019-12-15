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

      # That's the heart of the enhancers mecanism. This method sends the call
      # to the decorated object if this one can answer it, or raises an error.
      # @param name [String, Symbol] the name of the method to call on the decorated object.
      # @param args [Array] the arguments passed during the call to the function.
      # @param block [Block] the optional blockcode passed to the function.
      def method_missing(name, *args, &block)
        return enhance_association(name) if object.associations.key?(name)

        object.respond_to?(name) ? object.send(name, *args, &block) : super
      end

      # Determines if this object can transfer any of its calls to the decorated object.
      # @param name [String] the name of the called function.
      # @return [Boolean] TRUE if the decorated object can answer the call, FALSE otherwise.
      def respond_to_missing?(name, _include_private = false)
        object.respond_to? name
      end

      def enhance_association(name)
        elements = object.send(name.to_sym)
        return nil if elements.nil?
        return elements.map(&:enhance) if is_enhancable_collection?(name, elements)
        return elements.enhance if elements.respond_to?(:enhance)
        elements
      end

      def is_enhancable_collection?(name, elements)
        elements.kind_of?(Enumerable) && self.associations[name].klass.respond_to?(:enhancer)
      end
    end
  end
end
