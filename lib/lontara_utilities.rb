# frozen_string_literal: true

require_relative 'lontara_utilities/base_error'
require_relative 'lontara_utilities/git'
require_relative 'lontara_utilities/http_client'
require_relative 'lontara_utilities/rmq'
require_relative 'lontara_utilities/version'
require_relative 'lontara'

# Base module for Lontara Utilities
module LontaraUtilities
  module_function

  def git
    Git
  end

  def rmq
    RMQ
  end

  def http_client
    HTTPClient
  end

  def version
    VERSION
  end
end
