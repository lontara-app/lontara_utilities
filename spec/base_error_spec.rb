# frozen_string_literal: true

require 'spec_helper'

describe LontaraUtilities::BaseError do # rubocop:disable Metrics/BlockLength
  it 'has a base error class' do
    expect(described_class).to be_a(Class)
  end

  describe '.new' do
    it 'return a new instance of BaseError' do
      expect(described_class.new).to be_a(described_class)
    end
  end

  describe '.message' do
    it 'return a message' do
      expect(described_class.new.message).to eq('BaseError')
    end
  end

  describe '.code' do
    it 'return a code equal to class BaseError' do
      expect(described_class.new.code).to eq('BaseError')
    end
  end

  describe 'raise' do
    it 'raise a BaseError' do
      expect { raise described_class }.to raise_error(described_class)
    end
  end

  describe 'return inherited class' do
    # Create a new class inherited from BaseError
    let(:inherited_class) do
      Class.new(described_class) do
        def initialize(message = 'InheritedError') = super
      end
    end

    it 'return a new instance of inherited class' do
      expect(inherited_class.new).to be_a(inherited_class)
    end

    it 'return a message' do
      expect(inherited_class.new.message).to eq('InheritedError')
    end
  end

  describe '.handler' do
    let(:error) do
      described_class.new(handler: -> { Logger.new($stdout) })
    end

    it 'return a handler as a Logger' do
      expect(error.handler).to be_a(Logger)
    end
  end
end
