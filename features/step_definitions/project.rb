require 'fileutils'

Given(/^I have a project called "(.*?)"$/) do |name|
  @project_dir = "tmp/aruba/#{name}"

  FileUtils.mkdir_p @project_dir
  Dir.chdir @project_dir
end
