module Virtuatable
  module Builders
    module Helpers
      module Loaders
        # @!attribute [rw] loaders
        #   @return [Array] an array of loading functions invoked at startup.
        attr_accessor :loaders

        # Declares a loader in the current builder class.
        # @param loader [Symbol] the name of the loader, infered as the method name to call.
        def declare_loader(loader)
          @loaders.nil? ? @loaders = [loader] : @loaders << loader
        end
      end
    end
  end
end