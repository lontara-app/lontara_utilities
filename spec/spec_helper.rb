# frozen_string_literal: true

require_relative '../lib/lontara_utilities'
require 'rspec'
require 'webmock/rspec'

def current_release
  `git describe --tags --abbrev=0`.strip
end

def current_branch
  `git rev-parse --abbrev-ref HEAD`.strip
end

def current_remote_branch
  branches = `git branch -a`.split("\n").map { |branch| branch.gsub('*', '').strip }
  branches.select { |branch| branch.start_with?('remotes') }.first
end
