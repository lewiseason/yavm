require 'forwardable'

module YAVM
  class Versions
    extend ::Forwardable

    def initialize(versions)
      self.versions = versions.compact
    end

    # Set a given version to be the authoritative version for all defined stores
    def set_all!(authoritative_version)
      versions.each do |version|
        version.store.set!(authoritative_version)
      end
    end

    #
    # Get a list of versions which aren't the same version
    # as the first version, and boolean-ify that result
    #
    def equal?
      versions.reject { |v| v == versions.first }.length.zero?
    end

    def files
      versions.map { |v| v.store.filename || nil }.compact
    end

    def_delegators :versions, :<<, :length, :size, :[],
                   :first, :each, :each_with_index, :empty?, :any?, :map

    private

    attr_accessor :versions
  end
end
