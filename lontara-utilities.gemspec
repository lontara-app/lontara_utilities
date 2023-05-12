# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'json'
require 'lontara_utilities/version'

# Load JSON File for Gem metadata
metadata = JSON.parse(File.read('metadata.json')).transform_keys!(&:to_sym)

Gem::Specification.new do |spec|
  spec.version = LontaraUtilities::VERSION

  metadata.each do |key, value|
    # Create keys as methods
    spec.send("#{key}=", value)
  end

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.require_paths = ['lib']
  spec.required_ruby_version = '>= 3.1.0'

  spec.add_dependency 'bunny', '~> 2.20'
  spec.add_dependency 'connection_pool', '~> 2.4'
  spec.add_dependency 'faraday', '~> 2.7'
  spec.add_dependency 'json', '~> 2.6'
  spec.add_dependency 'securerandom', '~> 0.2'
  spec.add_dependency 'uri', '~> 0.12'

  spec.add_development_dependency 'byebug', '~> 11.1'
  spec.add_development_dependency 'rspec', '~> 3.12'
  spec.add_development_dependency 'webmock', '~> 3.18'
  spec.metadata['rubygems_mfa_required'] = 'true'
end
