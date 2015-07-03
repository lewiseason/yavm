Feature: GemSpec Store
  This store should update the version information
  in a gemspec file without mangling the gemspec

  Background:
    Given I have a project called "gemspec"
    And I have a gemspec at version "1.3.2" called "test.gemspec"

  Scenario: The file should exist in files subcommand
    Given I run `version files`
    Then the output should contain './test.gemspec'

  Scenario: Updating the version should be reflected in the file
    Given I increment the minor version in the semver store
    And I set all version stores
    And I run `cat ./test.gemspec`

    Then the output should match 'Gem::Specification.*\|([^\|]+)\|.*\1\.version\s+=\s+("|')([^"']+)(\2)'
    # ruby -c path_to_gemspec
    And the gemspec should be valid

