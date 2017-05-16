Given(/^I have a semver file containing:$/) do |content|

  Dir.chdir(expand_path '.') do
    open('.semver', 'w') { |file| file.write(content) }
  end
end
