# frozen_string_literal: true

module LontaraUtilities
  module RMQ
    # Initializing the connection to RabbitMQ.
    class Connection
      # **Connection can be initialized within a block.**
      #
      # If block is given, connection object will be yielded.
      # You can use the object to define the `exchange`, `queue`, or `reply queue`.
      #
      # Example:
      #
      #   def initialize(url, queue, reply_queue)
      #     Connection.new(url:) do |conn|
      #       @exchange = conn.channel.default_exchange
      #       @queue = conn.channel.queue(queue)
      #       @reply_queue = conn.channel.queue(reply_queue, exclusive: true)
      #     end
      #   end
      #   # ... your code goes here
      def initialize(url: ENV['RABBITMQ_URL'], default_exchange: true)
        @connection = Bunny.new(url)
        @connection.start

        @channel = channel_pool
        @exchange = channel.default_exchange if default_exchange
      end

      def close
        @connection.close
      end

      attr_reader :connection, :channel, :exchange

      private

      def channel_pool
        @channel_pool ||= ConnectionPool.new { @connection }.with(&:create_channel)
      end
    end
  end
end
