require 'aruba/cucumber'

Before do |scenario|
  @dirs = ['tmp/aruba']
  @cwd  = Dir.pwd
end

After do |scenario|
  Dir.chdir @cwd
end
