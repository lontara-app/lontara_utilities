# frozen_string_literal: true

require 'json'
require 'bunny'
require 'connection_pool'
require 'securerandom'

require_relative 'rmq/server/rpc_consumer'
require_relative 'rmq/client/rpc_producer'
require_relative 'rmq/server/subscriber'
require_relative 'rmq/client/publisher'
require_relative 'rmq/connection'
require_relative 'rmq/listener'
require_relative 'rmq/server'
require_relative 'rmq/client'
require_relative 'rmq/errors'

module LontaraUtilities
  # Lontara RMQ
  #
  # RMQ module responsible for handling AMQP connection
  # between services.
  module RMQ
    module_function

    # Instantiating RMQ connection.
    def connection(url:, **options)
      Connection.new(url:, **options)
    end

    # RPC Consumer server.
    # Options parameter are: `exchange:` and `exchange_type:`
    def rpc_consumer(connection, queue:, **options)
      Server::RPCConsumer.new(connection, queue:, **options)
    end

    # Publisher server.
    def subscriber(connection, queue:)
      Server::Subscriber.new(connection, queue:)
    end

    # RPC Producer client.
    # Options parameter are: `exchange:` and `exchange_type:`
    def rpc_producer(connection, queue:, reply_queue:, **options)
      Client::RPCProducer.new(connection, queue:, reply_queue:, **options)
    end

    # Publisher client.
    # Options parameter are: `exchange:` and `exchange_type:`
    def publisher(connection, queue:, **options)
      Client::Publisher.new(connection, queue:, **options)
    end

    def client
      Client
    end

    def server
      Server
    end
  end
end
