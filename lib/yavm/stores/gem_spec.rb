require 'rubygems'
require 'yavm/version'
require 'yavm/stores/base'

module YAVM
  module Stores
    class GemSpec < YAVM::Stores::Base
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
      # This might be a bit brittle.
      #
      def set!(new_version)
        # TODO: Can probably write a smarter regex here
        current_spec = IO.read(filename)
        spec_token   = current_spec.match(/Gem::Specification.new do \|(?<token>[^\|]+)\|/m)['token']
        new_spec     = current_spec.gsub(/^(\s+#{spec_token}\.version\s+=\s+)("|')([^"']+)(\2)/, "\\1\\2#{new_version}\\4")

        File.open(filename, 'w') { |f| f.write new_spec }
      end
    end
  end
end
