require 'aruba/cucumber'

Before do
  # Since we shell out in the tests, the `version` script
  # will only enable SimpleCov if this env var is set
  set_environment_variable 'COVERAGE', 'true'
end
