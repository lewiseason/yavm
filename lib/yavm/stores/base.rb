require 'json'

module YAVM
  module Stores
    class Base
      def name
        self.class.name
      end
      #
      # If the file for the store exists.
      # Only 1 file must match the glob.
      #
      def exists?
        Dir[glob].length == 1
      end

      #
      # Fetch the matched filename for this store
      #
      def filename
        Dir[glob].first if exists?
      end
    end

    class GenericJSON < YAVM::Stores::Base
      def data
        @data ||= JSON.parse(IO.read(filename))
      end

      def to_version
        Version.new(self, version_key)
      end

      def set!(new_version)
        @data = update_version_key(new_version.to_s)
        File.open(filename, 'w') { |f| f.write JSON.pretty_generate(data) }
      end
    end
  end
end
