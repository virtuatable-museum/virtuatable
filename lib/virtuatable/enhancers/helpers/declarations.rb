module Virtuatable
  module Enhancers
    module Helpers
      # This module holds the static methods to declare an enhancer
      # in another class, linking both and allowing to automatically
      # create enhanced instances by calling the same methods in the
      # enhancer that one would call on the enhanced class.
      #
      # @author Vincent Courtois <courtois.vincent@outlook.com>
      module Declarations
        # @!attribute [r] enhanced
        #   @return [Class] the class object of the enhanced object type.
        attr_reader :enhanced

        # Enhances the given class by declaring itself as its enhancer.
        # @param class_object [Class] the class to enhance.
        def enhances(class_object)
          @enhanced = class_object
          self_class = self
          class_object.singleton_class.class_eval do
            define_method :enhancer do
              self_class
            end
          end
          class_object.define_method :enhance! do
            self_class.new(self)
          end
        end
      end
    end
  end
end