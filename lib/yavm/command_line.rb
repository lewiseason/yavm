require 'docopt'
require 'yavm/stores'

module YAVM
  class CommandLine

    def initialize
      @invocation = File.basename($0)
    end

    def invoke!
      @args    = Docopt::docopt(doc)
      command  = @args.select { |a, v| commands.include?(a) && v }.keys.first
      command  = 'show' if command.nil?

      versions = YAVM::Stores.locate_versions

      if versions.empty? && !@args['init']
        puts "There doesn't seem to be any versioning information on this project."
        puts "Use native versioning tools (see docs for support), or run `#{@invocation} init`"
        puts "to use the default versioning method."
        exit(1)
      end

      # Commands which use the version information require it to be consistent
      if version_commands.include? command
        choose_authoritative!(versions) unless versions.equal?
        version = versions.first
      end

      case command
      when 'show'
        puts "#{version}"

      when 'inc'
        if @args['major']
          version.major += 1
          version.minor = version.patch = 0
          version.special = version.meta = nil

        elsif @args['minor']
          version.minor += 1
          version.patch = 0
          version.special = version.meta = nil

        elsif @args['patch']
          version.patch += 1
          version.special = version.meta = nil

        end

        versions.set_all!(version)

      when 'special'
        version.special = @args['<string>']

        versions.set_all!(version)

      when 'meta'
        version.meta = @args['<string>']

        versions.set_all!(version)

      when 'format'
        puts "#{version.format(@args['<string>'])}"

      when 'tag'
        puts "#{version.tag}"

      when 'help'
        Docopt::Exit.set_usage(nil)
        raise Docopt::Exit, doc.strip
      end

    end

    private

    def choose_authoritative!(versions)
      puts "Multiple version stores are in use, and aren't consistent."
      puts "  Please select the authoritative version:\n\n"
      puts "WARNING: File munging is dangerous. A manual resolution might be safer.\n\n"

      selection = ''

      while selection.is_a? String
        versions.each_with_index do |version, index|
          puts "   %3s: %-15s [%s]" % [index+1, version, version.store.name]
        end

        print "\nSelection: "
        selection = STDIN.gets.chomp

        if selection.to_i.to_s == selection && (1..versions.size) === selection.to_i
          selection = selection.to_i
          break
        end
      end

      authoritative_version = versions[selection.to_i - 1]

      versions.set_all!(authoritative_version)

      puts "Now on #{authoritative_version}"
      exit(0)

    end

    def doc
      <<-DOCOPT.gsub(/^ {6}/, '')
      YAVM. Yet Another Version Manager

      Usage:
        #{@invocation}
        #{@invocation} inc (major|minor|patch)
        #{@invocation} special [<string>]
        #{@invocation} meta [<string>]
        #{@invocation} format <string>
        #{@invocation} tag
        #{@invocation} help

      Options:
        inc          Increment a specific version number
        special      Set a special (eg: pre-release) suffix
        meta         Set a metadata version suffix
        format       Display version in specific format (%M, %m, %p, %s, %t)
        tag          Equivalent to format 'v%M.%m.%p%s'
        help         Show this screen.

      DOCOPT
    end

    #
    # A list of arguments which should be considered commands.
    # We should only ever see one of these at a time, typically.
    #
    def commands
      version_commands + support_commands
    end

    def version_commands
      ['show', 'inc', 'special', 'meta', 'format', 'tag']
    end

    def support_commands
      ['help']
    end

  end
end
