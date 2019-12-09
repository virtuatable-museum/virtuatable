# frozen_string_literal: true

module Virtuatable
  module Builders
    module Helpers
      # This helpers loads the folders specific in a specs loading scenario.
      # @author Vincent Courtois <courtois.vincent@outlook.com>
      module Tests
        extend ActiveSupport::Concern

        included do
          declare_loader(:tests, priority: 4)
        end

        # Loads the folders containing files related to the tests.
        # - spec/support contains files used to confiture each test module
        # - spec/shared contain all rspec shared examples and contexts
        def load_tests!
          require_folders('spec/support', 'spec/shared')
        end
      end
    end
  end
end
