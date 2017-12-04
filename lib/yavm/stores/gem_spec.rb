require 'rubygems'
require 'yavm/version'
require 'yavm/stores/base'

module YAVM
  module Stores
    class GemSpec < YAVM::Stores::Base
      REGEX = /(Gem::Specification\.new do \|([^\|]+)\|.*)(\2.version\s+=\s+("|'))(\S+)\4(.*)/m

      def name
        "gemspec: #{filename}"
      end

      def glob
        './*.gemspec'
      end

      def spec
        @spec ||= Gem::Specification.load(filename)
      end

      def to_version
        Version.new(self, spec.version.to_s.gsub('.pre.', '-'))
      end

      #
      # Munge the existing file to replace the version identifier.
      # This might be a bit brittle, although it's slightly better
      # than it was.
      #
      # The match groups in use are as follows
      #   1: Everything before the ".version =" line
      #   3: The start of that line, up to the opening quote
      #   4: Backreference to the opening quote
      #   6: The rest of the file
      #
      def set!(new_version)
        current_spec = IO.read(filename)

        new_spec = current_spec.gsub(REGEX) do
          m = Regexp.last_match
          next [m[1], m[3], new_version, m[4], m[6]].join
        end

        File.open(filename, 'w') { |f| f.write new_spec }
      end
    end
  end
end
