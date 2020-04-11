require File.join(__dir__, 'base.rb')

module Virtuatable
  module Files
    class Dockerfile < Base
      def initialize(service, options)
        super 'Dockerfile', options
        @options['service'] = service
      end
    end
  end
end