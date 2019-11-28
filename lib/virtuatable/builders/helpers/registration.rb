# frozen_string_literal: true

module Virtuatable
  module Builders
    module Helpers
      # Registers the service in the database by declaring it as a
      # Arkaan::Monitoring::Service object, and declaring the instance.
      # @author Vincent Courtois <courtois.vincent@outlook.com>
      module Registration
        extend ActiveSupport::Concern

        attr_accessor :service

        included do
          declare_loader(:registration)
        end

        def load_registration!
          @service = Arkaan::Monitoring::Service.create(key: @name, path: "/#{@name}")
        end
      end
    end
  end
end
