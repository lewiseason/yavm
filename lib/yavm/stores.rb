require 'yavm/versions'

require 'yavm/stores/semver'
require 'yavm/stores/package'
require 'yavm/stores/bower'
require 'yavm/stores/gem_spec'

module YAVM
  module Stores

    def stores
      [
        YAVM::Stores::Semver,
        YAVM::Stores::Package,
        YAVM::Stores::Bower,
        YAVM::Stores::GemSpec,
      ]
    end

    def locate_versions(quick = false)
      versions = stores.map do |store|
        store = store.new
        if store.exists?
          if quick
            return YAVM::Versions.new([store.to_version])
          else
            next store.to_version
          end
        end
      end

      YAVM::Versions.new(versions)
    end

    module_function :locate_versions, :stores
  end
end
