# frozen_string_literal: true

module LontaraUtilities
  module HTTPClient
    # Body Parser responsible for parsing body based on content type.
    class BodyParser
      def initialize(content_type:, body:)
        @content_type = content_type
        @body = body
      end

      # Parse body based on content type.
      def parse
        case content_type
        when 'application/json'
          body.to_json
        when 'application/x-www-form-urlencoded'
          URI.encode_www_form(body)
        else
          body
        end
      end

      private

      attr_reader :content_type, :body
    end
  end
end
