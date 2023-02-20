# frozen_string_literal: true

require_relative '../base_error'

module LontaraUtilities
  module RMQ
    module Errors
      class ClientParameterRequired < BaseError # rubocop:disable Style/Documentation
        def initialize(message = 'Client parameter required, and must be RPCProducer or Publisher.') = super
      end

      class DefaultExchangeParameterRequired < BaseError # rubocop:disable Style/Documentation
        def initialize(message = "Default exchange parameter required, and shouldn't be false.") = super
      end

      class ExchangeParameterRequired < BaseError # rubocop:disable Style/Documentation
        def initialize(message = 'Exchange parameter required unless default_exchange declared.') = super
      end
    end
  end
end
