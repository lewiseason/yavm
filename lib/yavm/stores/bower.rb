require 'yavm/stores/base'

module YAVM
  module Stores
    class Bower < YAVM::Stores::GenericJSON
      def name
        'bower.json file'
      end

      def glob
        './bower.json'
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
