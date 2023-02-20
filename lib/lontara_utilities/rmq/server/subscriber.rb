# frozen_string_literal: true

module LontaraUtilities
  module RMQ
    module Server
      # Server for AMQ on Direct Pattern
      class Subscriber
        def initialize(connection, queue:)
          @channel = connection.channel
          @queue = channel.queue(queue, durable: true)
        end

        # Start consuming the queue and process the request.
        def start
          queue.subscribe(manual_ack: true) do |delivery_info, _, body|
            @request = JSON.parse(body, symbolize_names: true)

            channel.ack(delivery_info.delivery_tag)

            process_request
          end
        end

        private

        attr_reader :channel, :queue, :request

        def process_request
          Listener.listen request
        end
      end
    end
  end
end
