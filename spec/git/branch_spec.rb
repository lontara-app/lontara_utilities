# frozen_string_literal: true

require 'spec_helper'

describe LontaraUtilities::Git::Branch do # rubocop:disable Metrics/BlockLength
  it 'has a branch class' do
    expect(described_class).to be_a(Class)
  end

  describe '.current_branch' do
    it 'return current branch' do
      expect(described_class.current_branch).to eq(current_branch)
    end
  end

  describe '.all' do
    it 'return all branches' do
      expect(described_class.all).to include(current_branch)
    end
  end

  describe '.remote' do
    it 'return all remote branches' do
      expect(described_class.remote).to include(current_remote_branch)
    end
  end

  describe '.local' do
    it 'return all local branches' do
      expect(described_class.local).to include(current_branch)
    end
  end

  describe '.master?' do
    it 'return true if current branch is master' do
      expect(described_class.master?).to be_falsey # Not master branch
    end
  end

  describe '.main?' do
    it 'return boolean either current branch is main or not' do
      expect(described_class.main?).to be_falsey # Not main branch
    end
  end
end
