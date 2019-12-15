# frozen_string_literal: true

module Virtuatable
  module API
    # Modules holding the responses that are NOT errors.
    # @author Vincent Courtois <courtois.vincent@outlook.com>
    module Responses
      # Builds a list of items as a standard API response.
      # The response will be a JSON hash containing two keys :
      # - :count will hold the number of items displayed in the list
      # - :items will hold the list of items.
      # @param items [Array] the items to format as a standard API response.
      def api_list(items)
        halt 200, {
          count: items.count,
          items: items.map(&:to_h)
        }.to_json
      end

      # Displays a creation standard response,
      # returning the informations about the created item.
      # @param item [Object] any object that responds to #to_h to display to the user.
      def api_created(item)
        halt 201, enhanced_json(item)
      end

      # Displays an item with the standards of the API.
      # @param item [Object] the item to display as a JSON formatted hash.
      def api_item(item)
        halt 200, enhanced_json(item)
      end

      # Displays a message with a 200 status code
      # @param message [String] the message to display with the API standards.
      def api_ok(message)
        api_item message: message
      end

      private

      def enhanced_json(item)
        item = item.enhance if item.respond_to?(:enhance)
        item.to_h.to_json
      end
    end
  end
end
