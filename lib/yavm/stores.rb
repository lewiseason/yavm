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

    def locate_versions
      versions = stores.map do |store|
        store = store.new
        next store.to_version if store.exists?
      end

      YAVM::Versions.new(versions)
    end

    module_function :locate_versions, :stores
  end
end
