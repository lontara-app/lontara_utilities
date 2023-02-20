# frozen_string_literal: true

require 'spec_helper'

describe LontaraUtilities::Git::Release do # rubocop:disable Metrics/BlockLength
  it 'has a release class' do
    expect(described_class).to be_a(Class)
  end

  describe '.current_release' do
    it 'returns current release' do
      expect(described_class.current_release).to eq(current_release)
    end
  end

  describe '.latest?' do
    it 'returns true if current release is latest' do
      expect(described_class.latest?(current_release)).to be_truthy
    end
  end

  describe '.latest' do
    it 'return latest version' do
      expect(described_class.latest).to eq(current_release)
    end
  end

  describe '.all' do
    it 'return all version' do
      expect(described_class.all).to include(current_release)
    end
  end

  describe '.current?' do
    it 'return true if current release is current release' do
      expect(described_class.current?(current_release)).to be_truthy
    end
  end
end
