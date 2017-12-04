require 'rubygems'
require 'cucumber'
require 'cucumber/rake/task'

Cucumber::Rake::Task.new(:cucumber) do |t|
  t.cucumber_opts = 'features --format pretty'
end

#
# We can't rely on the output simplecov provides because:
#   1. it's not actually started here, or by cucumber; and
#   2. It wouldn't include all the data from aruba
#
task :coverage_summary do |_t|
  file = 'tmp/coverage/index.html'

  if File.exist?(file)
    munge = IO.read(file)
    percent = munge.match(/covered_percent[^\d]*(?<coverage>[\d\.]{2,})%/)['coverage']
    puts ''"

    Code coverage for all files is: #{percent}%
    "''
  end
end

task test: %i[cucumber coverage_summary]
