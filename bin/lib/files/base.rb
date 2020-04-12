require 'bson'

module Virtuatable
  module Files
    class Base

      attr_reader :path

      attr_reader :options

      attr_reader :content

      attr_reader :stored_name

      def initialize(filename, options = {})
        @path = File.join(__dir__, '..', '..', 'utils', filename)
        @options = options.to_hash
      end

      def store
        name = "/tmp/#{BSON::ObjectId.new}"
        File.open(name, 'w+') { |file| file.write(content) }
        name
      end

      def content
        @content = read_content if @content.nil?
        @content
      end

      def read_content
        content = File.read @path
        options.each do |key, value|
          content.gsub!("{{#{key}}}", (value.to_s rescue ''))
        end
        content
      end
    end
  end
end