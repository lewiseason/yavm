Feature: Native .semver store
  Where no other versioning store is available, or to
  take advantage of any additional feautres, a yaml file
  called `.semver' will be available to store version
  information.

  Background:
    Given I have a project called "semver-file"
    And I have a semver file at version "1.3.2"

  Scenario: File should exist in files subcommand
    Given I run `version files`
    Then the output should contain './.semver'

  Scenario: Updating the version should be reflected in the file
    Given I increment the minor version in the semver store
    And I set all version stores
    And I run `cat ./.semver`

    Then the output should contain ':minor: 4'
