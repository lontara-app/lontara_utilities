# frozen_string_literal: true

module LontaraUtilities
  # This Base Error gives you a standard way to raise & handle errors with some additional features.
  #
  # Use this class directly:
  #
  #   begin
  #     raise LontaraUtilities::BaseError, 'This is a test'
  #   rescue LontaraUtilities::BaseError => e
  #     puts e.message
  #   end
  #
  # or inherited by other classes:
  #
  #   class RMQ::ConnectionError < LontaraUtilities::BaseError
  #     def initialize(message = "Can't established connection") = super
  #   end
  #
  # Note: You must call `super` in the initialize method of the inherited class.
  #
  # Parameter `handler` is a Proc or Any. If it is a Proc, it will be called.
  # If it is not a Proc, it will be assigned to the `handler` attribute.
  #
  #   class RMQ::QueueNotDefined < LontaraUtilities::BaseError
  #     def initialize(message = 'Queue not defined', handler: -> { logger }) = super
  #
  #     # Write logs to 'rmq.log'
  #     def logger
  #       File.open(File.join(__dir__, 'log', 'rmq.log'), 'a') do |f|
  #         f.puts "#{timestamp} | #{code} | #{message}"
  #       end
  #     end
  #   end
  #
  # You also can pass a Backtrace after the message in raise method.
  #
  #   raise LontaraUtilities::BaseError, 'This is a test', caller
  #
  # **Important**:
  # You cannot pass other arguments except `message`, and `backtrace`
  # to the raise method. `backtrace` only callable from rescue block also.
  class BaseError < StandardError
    # @param message [String] Error message. Default is 'LontaraUtilities::BaseError'.
    # @param code [String] Error code. Default is LontaraUtilities::BaseError, or the class name of the inherited class.
    # @param timestamp [Time] Error timestamp. Default is Time.now.
    # @param handler [Proc | Any] Error handler. Default is nil.
    def initialize(message = 'BaseError', code: self.class.name, timestamp: Time.now, handler: nil)
      @message = message
      @code = code.to_s.split('::').last
      @timestamp = timestamp
      @handler = handler.is_a?(Proc) ? handler.call : handler

      super(message)
    end

    attr_reader :message, :code, :timestamp, :handler
  end
end
