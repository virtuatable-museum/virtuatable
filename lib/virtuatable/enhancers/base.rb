module Virtuatable
  module Enhancers
    # Base class to be extended by all enhancers. It provides a way to declare
    # this class as the enhancer of another class, to access the properties
    # of the enhanced class as instance attributes.
    #
    # @author Vincent Courtois <courtois.vincent@outlook.com>
    class Base
      extend Virtuatable::Enhancers::Helpers::Declarations

      attr_reader :object

      def initialize(object)
        @object = object
      end

      def method_missing(name, *args, &block)
        if object.respond_to? name
          object.send(name, *args, &block)
        else
          super(name, *args, &block)
        end
      end
    end
  end
end