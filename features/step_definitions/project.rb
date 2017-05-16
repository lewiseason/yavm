require 'securerandom'

Given(/^I have a (?:project|component) called "(.*?)"$/) do |name|
  # Give each instance of a project/component/feature its own tmp dir
  @project_dir = "#{name}-#{SecureRandom.hex(4)}"

  create_directory @project_dir
  cd @project_dir
end
