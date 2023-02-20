# frozen_string_literal: true

module LontaraUtilities
  module RMQ
    # Listener for RabbitMQ.
    #
    # This class used to define the listener for each request type.
    # Same as routes.rb in Rails, that define the routes for each request type
    # and the method to be called.
    class Listener
      def self.listen(request)
        new(request).start
      end

      def initialize(request)
        @id = request[:id] if request[:id].present?
        @pattern = request[:pattern]
        @data = request[:data]
      end

      # Start listening the request and process it to the defined listener.
      def start
        # Merge message ID if present.
        id.present? ? { id: }.merge!(listener_response) : listener_response
      rescue StandardError => e
        id.present? ? { id: }.merge!(error_response(e)) : error_response(e)
      end

      private

      attr_reader :id, :pattern, :data

      def listener_response
        RMQRoutes.draw(with: pattern, data:)
      end

      def error_response(error)
        {
          type: :error,
          timestamp: Time.now.to_i,
          data: {
            message: error.message,
            code: error.class.name.split('::').last,
            stacktrace: error.backtrace
          }
        }
      end
    end
  end
end
