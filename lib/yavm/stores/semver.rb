require 'fileutils'
require 'yaml'
require 'yavm/stores/base'

module YAVM
  module Stores
    class Semver < YAVM::Stores::Base

      def name
        '.semver file'
      end

      def glob
        './.semver'
      end

      def create!
        FileUtils.touch '.semver'
      end

      def data
        @data ||= YAML.load_file(filename)
      end

      def to_version
        Version.new(self, data)
      end

      def set!(new_version)
        File.open(filename, 'w') { |f| f.write new_version.to_yaml }
      end

    end
  end
end
