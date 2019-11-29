module Virtuatable
  module Builders
    module Helpers
      # This module loads the file for a standard application,
      # not loading the files needed for specs or websockets.
      # @author Vincent Courtois <courtois.vincent@outlook.com>
      module Folders
        extend ActiveSupport::Concern

        included do
          declare_loader(:folders)
        end

        def load_folders!
          require_folders('controllers', 'services', 'decorators')
        end
      end
    end
  end
end