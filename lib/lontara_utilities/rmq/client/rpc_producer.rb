# frozen_string_literal: true

module LontaraUtilities
  module RMQ
    module Client
      # Client for AMQ on RPC Pattern
      class RPCProducer
        def initialize(connection, queue:, reply_queue: 'amq.rabbitmq.reply-to')
          @channel = connection.channel
          @exchange = connection.exchange
          @queue = channel.queue(queue, durable: true)
          @reply_queue = channel.queue(reply_queue, durable: true)

          # Consumer must be initialized to Reply Queue
          # before publishing the message.
          consume_reply
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
        def publish(&block) # rubocop:disable Metrics/AbcSize
          @request = block.call
          @request_id = SecureRandom.uuid

          exchange.publish(
            request.to_json,
            routing_key: queue.name,
            correlation_id: request_id,
            reply_to: reply_queue.name
          )

          # waits for the signal from #consume_reply
          lock.synchronize { condition.wait(lock) }

          response
        end

        private

        attr_reader :channel,
                    :exchange,
                    :queue,
                    :reply_queue,
                    :request_id,
                    :lock,
                    :condition,
                    :request,
                    :response

        def consume_reply
          @lock = Mutex.new
          @condition = ConditionVariable.new

          reply_queue.subscribe do |_delivery_info, properties, payload|
            if properties[:correlation_id] == request_id
              @response = payload

              # sends the signal to continue the execution of #call
              lock.synchronize { condition.signal }
            end
          end
        end
      end
    end
  end
end
