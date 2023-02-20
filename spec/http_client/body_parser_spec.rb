# frozen_string_literal: true

require 'spec_helper'

describe LontaraUtilities::HTTPClient::BodyParser do
  describe '.parse' do
    it 'returns parsed body' do
      expect(described_class.new(
        content_type: 'application/json',
        body: { foo: 'bar' }
      ).parse).to eq('{"foo":"bar"}')

      expect(described_class.new(
        content_type: 'application/x-www-form-urlencoded',
        body: { foo: 'bar' }
      ).parse).to eq('foo=bar')

      expect(described_class.new(
        content_type: 'text/plain',
        body: { foo: 'bar' }
      ).parse).to eq({ foo: 'bar' })
    end
  end
end
