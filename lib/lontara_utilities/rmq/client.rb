# frozen_string_literal: true

module LontaraUtilities
  module RMQ
    # Base module for RMQ client.
    module Client
      class << self
        # Client interface for RMQ Publisher or RPC Publisher.
        #
        # Start client by giving url and queue name.
        # Parameter client must be `RPCProducer` or `Publisher`.
        # If parameter not defined, default is `RPCProducer`.
        #
        # **Use `Publisher` if no need to listen the request's responses.**
        #
        # Options params are:
        # - `default_exchange: (default: true)`
        #
        # That option is changing the way Connection object is created.
        # If set to `false`, connection object didn't create exchange, also connection.exchange property will be `nil`.
        #
        # - `queue:`,
        # - `reply_queue: (default: 'amq.rabbitmq.reply-to')`
        # (Reply queue is only applicable if `client` is `RPCProducer`).
        #
        # These options only applicable if `default_exchange` is `false`, and `client` is `Publisher` (exchange created inside consumer).
        #  - `exchange:`
        #  - `exchange_type: (default: :direct)`
        def start(url: ENV['RABBITMQ_URL'], client: 'RPCProducer', **options)
          parameter_validator(client, options)

          client_opts = client_opts_assigner(client, options)
          conn_opts = %i[exchange exchange_type]
          client = Object.const_get("LontaraUtilities::RMQ::Client::#{client}")

          @connection = Connection.new(url:, **options.slice(*conn_opts))

          @client = client.new(@connection, **client_opts)

          self
        end

        def publish(request)
          @client.publish { request }
        end

        def stop
          @connection.close
        end

        private

        def client_opts_assigner(client, options)
          pubsub_opts = %i[queue exchange exchange_type]
          rpc_opts = %i[queue reply_queue]

          return options.slice(*pubsub_opts) if client == 'Publisher'
          return options.slice(*rpc_opts) if client == 'RPCProducer'
        end

        def parameter_validator(client, options)
          raise Errors::ClientParameterRequired unless %w[RPCProducer Publisher].include?(client)

          return unless options[:default_exchange] == false
          raise Errors::DefaultExchangeParameterRequired if client == 'Publisher'

          return unless options[:exchange].nil?

          raise Errors::ExchangeParameterRequired
        end
      end
    end
  end
end
