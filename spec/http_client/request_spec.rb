# frozen_string_literal: true

describe LontaraUtilities::HTTPClient::Request do # rubocop:disable Metrics/BlockLength
  let(:url) { 'http://example.com' }

  describe 'Get Request' do
    it 'returns response' do
      stub_request(:get, url).to_return(status: 200, body: 'OK', headers: {})
      expect(described_class.new(:get, url:).perform).to be_a(Faraday::Response)
    end
  end

  describe 'Post Request' do
    it 'returns response' do
      stub_request(:post, url).to_return(status: 200, body: 'OK', headers: {})
      expect(described_class.new(:post, url:).perform).to be_a(Faraday::Response)
    end
  end

  describe 'Put Request' do
    it 'returns response' do
      stub_request(:put, url).to_return(status: 200, body: 'OK', headers: {})
      expect(described_class.new(:put, url:).perform).to be_a(Faraday::Response)
    end
  end

  describe 'Patch Request' do
    it 'returns response' do
      stub_request(:patch, url).to_return(status: 200, body: 'OK', headers: {})
      expect(described_class.new(:patch, url:).perform).to be_a(Faraday::Response)
    end
  end

  describe 'Delete Request' do
    it 'returns response' do
      stub_request(:delete, url).to_return(status: 200, body: 'OK', headers: {})
      expect(described_class.new(:delete, url:).perform).to be_a(Faraday::Response)
    end
  end
end
