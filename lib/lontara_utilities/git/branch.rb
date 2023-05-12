# frozen_string_literal: true

module LontaraUtilities
  module Git
    # Class Branch used to show all git branches in your project.
    class Branch
      # Show current running branch in your project.
      def self.current_branch
        `git rev-parse --abbrev-ref HEAD`.strip
      end

      # Show all branches in your project.
      def self.all
        `git branch -a`.split("\n").map { |branch| branch.gsub('*', '').strip }
      end

      # Show all remote branches in your project.
      def self.remote
        all.select { |branch| branch.start_with?('remotes') }
      end

      # Show all local branches in your project.
      def self.local
        all.reject { |branch| branch.start_with?('remotes') }
      end

      # Use metaprogramming to define methods
      # for checking current branch using method_missing and plain ruby method.
      def self.method_missing(method_name, *args, &)
        if method_name.to_s.end_with?('?')
          current_branch == method_name.to_s.gsub('?', '')
        else
          super
        end
      end

      def self.respond_to_missing?(method_name, include_private = false)
        method_name.to_s.end_with?('?') || super
      end
    end
  end
end
