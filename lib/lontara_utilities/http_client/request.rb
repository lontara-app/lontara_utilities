# frozen_string_literal: true

module LontaraUtilities
  module HTTPClient
    # Request class responsible for handling HTTP request.
    class Request
      def initialize(method, url:, headers: {}, body: nil, params: nil, timeout: 20) # rubocop:disable Metrics/ParameterLists
        @method = method
        @url = url
        @headers = headers
        @body = body
        @params = params
        @timeout = timeout

        headers.merge!(user_agent:) unless headers.key?(:user_agent)
      end

      # Perform HTTP request.
      def perform
        call
      end

      private

      attr_reader :method, :url, :headers, :body, :params, :timeout

      def call
        connection.send(method, url) do |req|
          req.body = parsed_body if body
          req.params = params if params
          req.options.timeout = timeout
          req.options.open_timeout = timeout
        end
      end

      def connection
        Faraday.new do |faraday|
          faraday.headers = headers
          faraday.adapter Faraday.default_adapter
        end
      end

      def parsed_body
        BodyParser.new(**headers.slice(:content_type), body:).parse
      end

      def app_name
        # Check if Rails is defined
        return 'Lontara HTTPClient' unless defined?(Rails)

        Rails.application.class.module_parent.name
      end

      def app_version
        release = Git::Release.current_release
        return VERSION if release.empty?

        release
      end

      def user_agent
        "#{app_name}/#{app_version}"
      end
    end
  end
end
