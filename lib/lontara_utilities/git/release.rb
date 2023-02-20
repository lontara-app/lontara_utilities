# frozen_string_literal: true

module LontaraUtilities
  module Git
    # Class Release used to show all release tag in your project.
    class Release
      # Show current running release in your project.
      def self.current_release
        `git describe --tags --abbrev=0`.strip
      end

      # Show all release in your project.
      def self.all
        `git tag`.split("\n").map(&:strip)
      end

      # Show latest release in your project.
      def self.latest
        all.last
      end

      # Check if current release is latest release.
      def self.latest?(release)
        release = release.to_s.downcase.gsub('v', '')
        latest == release
      end

      # Check if release is current release.
      def self.current?(release)
        release = release.to_s.downcase.gsub('v', '')
        current_release == release
      end
    end
  end
end
