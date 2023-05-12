# frozen_string_literal: true

module LontaraUtilities
  module RMQ
    module Client
      # Client for AMQ on Pub/Sub Pattern
      class Publisher
        def initialize(connection, queue:, exchange: nil, exchange_type: :direct)
          @channel = connection.channel

          # Use `default_exchange` if exchange is not declared in parameter
          # nor use the specified exchange from the connection.
          x = -> { exchange.nil? ? channel.default_exchange : channel.exchange(exchange, type: exchange_type) }
          @exchange = connection.exchange.nil? ? x.call : connection.exchange

          @queue = channel.queue(queue, durable: true)
        end

        # Publish message to the queue.
        #
        # This method will yield the block to get the message.
        # Message published to NestJS Service must contain `id` key.
        #
        # Example:
        #
        # ```
        # client.publish do
        #   {
        #     id: 'message_1',
        #     pattern: 'voucher.voucher.find_one',
        #     data: { id: 1 }
        #   }
        # end
        # ```
        def publish(&block)
          @request = block.call

          exchange.publish(
            request.to_json,
            routing_key: queue.name
          )
        end

        private

        attr_reader :channel, :exchange, :queue, :request_id, :request
      end
    end
  end
end
