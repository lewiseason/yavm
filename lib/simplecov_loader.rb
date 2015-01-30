require 'simplecov'

invoke_name = File.basename $PROGRAM_NAME
invoke_time = (Time.now.to_f * 1000).to_i
invoke_type = ARGV.first || '[show]'

SimpleCov.root ('../' * 5)
SimpleCov.command_name "#{invoke_name} #{invoke_type} (#{invoke_time})"
SimpleCov.start
