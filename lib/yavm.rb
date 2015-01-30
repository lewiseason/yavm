lib = File.dirname(__FILE__)
$:.unshift lib unless $:.include?(lib)

require 'yavm/version'
require 'yavm/stores'

module YAVM

  def version(quiet: true, quick: true)
    versions = YAVM::Stores.locate_versions(quick)

    if versions.equal?
      return versions.first
    else
      return nil if quiet

      raise RuntimeError, 'No version information available'
    end
  end

  module_function :version

end
