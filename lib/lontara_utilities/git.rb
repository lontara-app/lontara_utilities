# frozen_string_literal: true

require_relative 'git/branch'
require_relative 'git/release'

module LontaraUtilities
  # Module Git responsible for handling git Branch and Release.
  module Git
    module_function

    # Module function of Git Branch.
    # Call this function like this: `LontaraUtilities::Git.branch#method_name`
    def branch
      Branch
    end

    # Module function of Git Release.
    # Call this function like this: `LontaraUtilities::Git.release#method_name`
    def release
      Release
    end
  end
end
