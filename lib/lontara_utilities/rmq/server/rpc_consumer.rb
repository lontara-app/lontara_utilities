# frozen_string_literal: true

module LontaraUtilities
  module RMQ
    module Server
      # Server for AMQ on RPC Pattern,m
      class RPCConsumer
        def initialize(connection, queue:)
          @channel = connection.channel
          @exchange = connection.exchange
          @queue = channel.queue(queue, durable: true)
        end

        # Start consuming the queue, process the request, and publish the response.
        def start
          queue.subscribe do |_, properties, payload|
            @request = JSON.parse(payload, symbolize_names: true)

            publish_response(properties.reply_to, properties.correlation_id)
          end
        end

        private

        attr_reader :channel, :exchange, :queue, :request, :response

        def publish_response(reply_queue, correlation_id)
          process_request

          exchange.publish(response.to_json, routing_key: reply_queue, correlation_id:)
        end

        def process_request
          @response = Listener.listen request
        end
      end
    end
  end
end
