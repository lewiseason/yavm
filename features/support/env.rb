require 'aruba/cucumber'

Before do |_scenario|
  @dirs = ['tmp/aruba']
  @cwd  = Dir.pwd

  set_env('COVERAGE', 'true')
end

After do |_scenario|
  Dir.chdir @cwd
end
