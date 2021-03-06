lib = File.dirname(__FILE__)
$LOAD_PATH.unshift lib unless $LOAD_PATH.include?(lib)

require 'yavm/version'
require 'yavm/stores'

module YAVM
  def version(quiet: true, quick: true)
    versions = YAVM::Stores.locate_versions(quick)

    if versions.equal?
      return versions.first
    else
      return nil if quiet

      raise 'No version information available'
    end
  end

  def versions
    YAVM::Stores.locate_versions
  end

  module_function :version, :versions
end
