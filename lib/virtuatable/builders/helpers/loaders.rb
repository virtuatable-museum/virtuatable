# frozen_string_literal: true

module Virtuatable
  module Builders
    module Helpers
      # Add the methods to declare an array of loaders into a builder class.
      # @author Vincent Courtois <courtois.vincent@outlook.com>
      module Loaders
        # @!attribute [rw] loaders
        #   @return [Array] an array of loading functions invoked at startup.
        attr_accessor :loaders

        # Declares a loader in the current builder class.
        # @param loader [Symbol] the name of the loader, infered as the method name to call.
        def declare_loader(loader, priority:)
          loader_h = {name: loader.to_sym, priority: priority}
          @loaders.nil? ? @loaders = [loader_h] : @loaders << loader_h
        end
      end
    end
  end
end
