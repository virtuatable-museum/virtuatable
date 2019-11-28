module Virtuatable
  module Builders
    module Helpers
      module Loaders
        extend ActiveSupport::Concern

        # @!attribute [rw] loaders
        #   @return [Array] an array of loading functions invoked at startup.
        attr_accessor :loaders

        def declare_loader(loader)
          @loaders.nil? ? @loaders = [loader] : @loaders << loader
        end
      end
    end
  end
end