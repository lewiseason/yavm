require 'docopt'
require 'yavm/stores'

module YAVM
  #
  # Command line interface for the `version` command.
  #
  class CommandLine
    def initialize
      @invocation = File.basename($PROGRAM_NAME)
    end

    def invoke!
      @args     = Docopt.docopt(doc)
      command   = @args.select { |a, v| commands.include?(a) && v }.keys.first
      command ||= 'show'

      versions = Stores.locate_versions

      if versions.empty? && !@args['init']
        puts <<-MESSAGE.gsub(/^ {10}/, '').strip
          There doesn't seem to be any versioning information on this project.
          Use native versioning tools (see docs for support), or run `#{@invocation} init`
          to use the built-in versioning method.
        MESSAGE
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
        version.increment :major if @args['major']
        version.increment :minor if @args['minor']
        version.increment :patch if @args['patch']

        versions.set_all!(version)

        puts "#{version}"

      when 'special'
        version.special = @args['<string>']
        versions.set_all!(version)

        puts "#{version}"

      when 'meta'
        version.meta = @args['<string>']
        versions.set_all!(version)

        puts "#{version}"

      when 'init'
        # Check if a Semver store is already defined - we should never attempt
        # to initialize a new one if an existing one is found.
        if versions.map { |v| v.store.class }.include? YAVM::Stores::Semver
          message = <<-MESSAGE.gsub(/^ {12}/, '').strip
            A .semver file already exists at version #{version}
            See `#{@invocation} help` for details on working with
            the existing version file.
          MESSAGE

          fail message
        end

        store  = Stores::Semver.new
        store.create!

        semver = Version.new(store)
        store.set!(semver)

        versions = Stores.locate_versions

        if version
          puts <<-MESSAGE.gsub(/^ {12}/, '').strip
            A version is already defined (#{version}),
            I'll copy that to the new .semver file.

          MESSAGE

          versions.set_all!(version)
        end

        puts "#{version || semver}"

      when 'format'
        puts "#{version.format(@args['<string>'])}"

      when 'tag'
        puts "#{version.tag}"

      when 'files'
        sep = "\n"
        sep = ' '  if @args['-1']
        sep = "\0" if @args['-0']

        puts versions.map { |v| v.store.filename || nil }.compact.join(sep)

      when 'help'
        Docopt::Exit.set_usage(nil)
        fail Docopt::Exit, doc.strip
      end
    end

    private

    def choose_authoritative!(versions) # rubocop:disable Metrics/AbcSize
      puts "Multiple version stores are available, and aren't consistent."
      puts "Please select the authoritative version:\n\n"
      puts "WARNING: Munging can be dangerous - a manual resolution might be safer.\n\n"

      selection = ''

      while selection.is_a? String
        versions.each_with_index do |version, index|
          puts format('   %3s: %-15s [%s]', index + 1, version, version.store.name)
        end

        print "\nSelection: "
        selection = STDIN.gets.chomp

        # rubocop:disable Style/CaseEquality
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
        #{@invocation} init
        #{@invocation} inc (major|minor|patch)
        #{@invocation} special [<string>]
        #{@invocation} meta [<string>]
        #{@invocation} format <string>
        #{@invocation} tag
        #{@invocation} files [(-1|-0)]
        #{@invocation} help

      Options:
        inc          Increment a specific version number
        init         Create a .semver file for tracking versioning
        special      Set a special (eg: pre-release) suffix
        meta         Set a metadata version suffix
        format       Display version in specific format (%M, %m, %p, %s, %t, %-s, %-t)
        tag          Equivalent to format 'v%M.%m.%-p%-s'
        files        List the files which store version information
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
      %w(show inc special meta init format tag)
    end

    def support_commands
      %w(help files)
    end
  end
end
