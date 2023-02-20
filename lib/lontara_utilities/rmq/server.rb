# frozen_string_literal: true

module LontaraUtilities
  module RMQ
    # Base module for RMQ server.
    module Server
      class << self
        # Server interface for RMQ Publisher or RPC Publisher.
        #
        # Start server by giving url and queue name.
        # Parameter server must be `RPCConsumer` or `Subscriber`.
        # If parameter not defined, default is `RPCConsumer`.
        #
        # **Use `Subscriber` if no need to reply the request's responses.**
        #
        # Options params is: `default_exchange: (default: true)`
        #
        # That option is changing the way Connection object is created.
        # If set to `false`, connection object didn't create exchange, also connection.exchange property will be `nil`.
        #
        # These options only applicable if `default_exchange` is `false`, and `server` is `RPCConsumer` (exchange created inside consumer).
        #  - `exchange:`
        #  - `exchange_type: (default: :direct)`
        #
        # Be aware of this conditions:
        # - Don't leave `exchange` where `default_exchange` is `false`, or Server object will raise error.
        def start(url:, queue:, server: 'RPCConsumer', **options)
          parameter_validator(server, options)

          server = Object.const_get("LontaraUtilities::RMQ::Server::#{server}")
          server_opts = %i[exchange exchange_type]

          connection = Connection.new(url:, **options.except(*server_opts))

          server.new(connection, queue:, **options.slice(*server_opts)).start
        end

        private

        def parameter_validator(server, options)
          raise ArgumentError, 'server parameter is required, and must be RPCConsumer or Subscriber' if server.nil?

          return unless options[:default_exchange] == false
          raise ArgumentError, "default_exchange shouldn't be false if server is RPCConsumer" if server == 'RPCConsumer'

          return unless options[:exchange].nil?

          raise ArgumentError, 'exchange parameter is required if default_exchange is false'
        end
      end
    end
  end
end
