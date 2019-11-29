# frozen_string_literal: true

module Virtuatable
  module Builders
    module Helpers
      # Registers the service in the database by declaring it as a
      # Arkaan::Monitoring::Service object, and declaring the instance.
      # @author Vincent Courtois <courtois.vincent@outlook.com>
      module Registration
        extend ActiveSupport::Concern

        # @!attribute [r] service
        #   @return [Arkaan::Monitoring::Service] the service linked to this application.
        attr_reader :service
        # @!attribute [r] instance
        #   @return [Arkaan::Monitoring::Instance] the instance of this application.
        attr_reader :instance

        included do
          declare_loader(:registration)
        end

        # Registers the service in the micro-services registry (consisting in
        # the arkaan_monitoring_services and arkaan_monitoring_instances collections)
        def load_registration!
          @service = Arkaan::Monitoring::Service.first_or_create!(
            key: @name,
            path: "/#{@name}"
          )
          @instance = service.instances.first_or_create!(
            type: ENV['INSTANCE_TYPE'].to_sym,
            url: ENV['SERVICE_URL']
          )
        end
      end
    end
  end
end
