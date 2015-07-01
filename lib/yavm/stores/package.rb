require 'yavm/stores/base'

module YAVM
  module Stores
    class Package < YAVM::Stores::GenericJSON
      def name
        'npm package.json'
      end

      def glob
        './package.json'
      end

      def version_key
        data['version']
      end

      def update_version_key(what)
        data['version'] = what
        data
      end
    end
  end
end
