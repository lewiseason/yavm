require 'forwardable'
require 'ostruct'

module YAVM
  class Version
    extend ::Forwardable

    VERSION_REGEX = /\A(?<major>\d+)\.(?<minor>\d+)\.(?<patch>\d+)(?:-(?<special>[a-z0-9]+))?(?:\+(?<meta>[a-z0-9]+))?\z/i

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

    def to_s
      format('%M.%m.%p%-s')
    end

    def to_hash
      @_version.marshal_dump
    end

    def to_yaml
      to_hash.to_yaml
    end

    def to_json
      to_hash.to_json
    end

    def tag
      format('v%M.%m.%p%-s%-t')
    end

    def format(string = '')
      string.gsub(/(%-?[Mmpst%])/, {
        '%M' => major.to_s,
        '%m' => minor.to_s,
        '%p' => patch.to_s,
        '%s' => special.to_s,
        '%t' => meta.to_s,
        '%-s' => special.to_s.empty? ? '' : "-#{special}",
        '%-t' => meta.to_s.empty? ? '' : "+#{meta}",
        '%%' => '%'
      })
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
      when :minor
        self.minor += 1
      when :patch
        self.patch += 1
      else
        fail "Can't increment #{what}"
      end
    end

    def major=(value)
      clears(:minor, :patch, :special, :meta)
      @_version.major = value
    end

    def minor=(value)
      clears(:patch, :special, :meta)
      @_version.minor = value
    end

    def patch=(value)
      @_version.patch = value
    end

    private

    def clears(*properties)
      properties.each do |p|
        value = @_version.send(p).is_a?(Fixnum) ? 0 : ''
        @_version.send("#{p}=", value)
      end
    end

    def empty
      @_version = OpenStruct.new ({
        major: 0, minor: 0, patch: 0, special: '', meta: ''
      })
    end

    def parse(string)
      match = string.match(VERSION_REGEX)

      @_version = Hash[match.names.zip(match.captures)]
      @_version = OpenStruct.new(@_version)
      integerize!
      stringify!
    end

    def load(hash)
      @_version = OpenStruct.new(hash)
      integerize!
      stringify!
    end

    def integerize!
      @_version.major = @_version.major.to_i
      @_version.minor = @_version.minor.to_i
      @_version.patch = @_version.patch.to_i
    end

    def stringify!
      @_version.special ||= ''
      @_version.meta ||= ''
    end

    #
    # Allows calling "version.minor" and the like on the Version instance
    #
    def_delegators :@_version,
                   :major, :minor, :patch,
                   :special,  :meta,
                   :special=, :meta=
  end
end
