lib = File.dirname(__FILE__)
$:.unshift lib unless $:.include?(lib)

require 'yavm/version'
require 'yavm/stores'

module YAVM

  def find(quiet = true)
    versions = YAVM::Stores.locate_versions

    if versions.equal?
      return versions.first
    else
      return nil if quiet

      raise RuntimeError, ''

    end

  end

  module_function :find

end
