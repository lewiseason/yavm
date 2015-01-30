require 'aruba/cucumber'

Before do |scenario|
  @dirs = ['tmp/aruba']
  @cwd  = Dir.pwd

  set_env('COVERAGE', 'true')
end

After do |scenario|
  Dir.chdir @cwd
end
