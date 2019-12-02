# frozen_string_literal: true

module Virtuatable
  # Wrapping class to easily create builders.
  # @author Vincent Courtois <courtois.vincent@outlook.com>
  class Application
    include Singleton

    # @!attribute [rw] builder
    #   @return [Virtuatable::Builders::Base] the base builder for the application.
    attr_accessor :builder

    # Loads the application in normal mode, call this from a config.ru file to
    # load the environment, configuration, and require the necessary files.
    # @param name [String] the name of the service you're loading.
    def self.load!(name, locations: caller_locations, path: '.')
      self.instance.builder = Virtuatable::Builders::Base.new(
        locations: locations,
        path: path,
        name: name
      )
    end

    # Loads the application from a spec/spec_helper to load the specs.
    # @param name [String] the name of the service to load the specs of.
    def self.load_tests!(name, locations: caller_locations, path: '..')
      self.instance.builder = Virtuatable::Builders::Tests.new(
        locations: locations,
        path: path,
        name: name
      )
    end

    # Wrapper to simplify the call to instance.:builder
    # @return [Virtuatable::Builders::Base] the builder of the current application.
    def self.builder
      instance.builder
    end
  end
end
