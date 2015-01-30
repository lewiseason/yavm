require 'forwardable'
require 'ostruct'

module YAVM
  class Version
    extend ::Forwardable

    attr_accessor :store

    def initialize(store, vobject = nil)
      self.store = store

      case vobject
      when String
        parse(vobject)
      when Hash
        load(vobject)
      when nil
        empty
      end
    end

    def special
      empty_is_nil(:special)
    end

    def meta
      empty_is_nil(:meta)
    end

    def to_s
      format('%M.%m.%p%s')
    end

    def to_hash
      dump = @_version.marshal_dump
      dump[:special] ||= ''
      dump[:meta]    ||= ''

      dump
    end

    def to_yaml
      to_hash.to_yaml
    end

    def to_json
      to_hash.to_json
    end

    def tag
      format('v%M.%m.%p%s%t')
    end

    def format(string = '')
      string = string.dup

      # ? http://stackoverflow.com/a/8132638
      string.gsub!('%M', major.to_s)
      string.gsub!('%m', minor.to_s)
      string.gsub!('%p', patch.to_s)
      string.gsub!('%s', special ? "-#{special}" : '')
      string.gsub!('%t', meta ? "+#{meta}" : '')
      string.gsub!('%%', '%')

      string
    end

    # rubocop:disable Style/RedundantSelf
    def ==(other)
      self.major == other.major &&
        self.minor == other.minor &&
        self.patch == other.patch &&
        self.special == other.special
    end

    def increment(what)
      case what
      when :major
        self.major += 1
        self.minor  = 0
        self.patch  = 0
      when :minor
        self.minor += 1
        self.patch  = 0
      when :patch
        self.patch += 1
      else
        fail "Can't increment #{what}"
      end

      if [:major, :minor, :patch].include? what
        self.special = nil
        self.meta    = nil
      end
    end

    private

    def empty_is_nil(key)
      value = @_version.send(key) || ''
      value.empty? ? nil : value
    end

    def empty
      @_version = OpenStruct.new ({
        major: 0, minor: 0, patch: 0, special: '', meta: ''
      })
    end

    def parse(string)
      match = string.match(/\A(?<major>\d+)\.(?<minor>\d+)\.(?<patch>\d+)(?:-(?<special>[a-z0-9]+))?(?:\+(?<meta>[a-z0-9]+))?\z/i)

      @_version = Hash[match.names.zip(match.captures)]
      @_version = OpenStruct.new(@_version)
      integerize!
    end

    def load(hash)
      @_version = OpenStruct.new(hash)
      integerize!
    end

    def integerize!
      @_version.major = @_version.major.to_i
      @_version.minor = @_version.minor.to_i
      @_version.patch = @_version.patch.to_i
    end

    #
    # Allows calling "version.minor" and the like on the Version instance
    #
    def_delegators :@_version,
                   :major,  :minor,  :patch,
                   :major=, :minor=, :patch=, :special=, :meta=
  end
end
