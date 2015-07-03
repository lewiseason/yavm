require 'fileutils'

Given(/^I have a (?:project|component) called "(.*?)"$/) do |name|
  # Give each project/component/feature its own tmp dir
  @dirs << name
end
