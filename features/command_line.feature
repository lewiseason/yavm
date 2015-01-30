Feature: Command Line Interface
  The command line interface allows the end-user to increment the
  version number, and set the 'special' and 'meta' fields

  Background:
    Given I have a project called "project"
    And I run `version init`

    Then the output should contain "0.0.0"

  Scenario: Incrementing major version
    Given I run `version inc major`
    Then the output should contain "1.0.0"

  Scenario: Incrementing minor version
    Given I run `version inc minor`
    Then the output should contain "0.1.0"

  Scenario: Incrementing patch level
    Given I run `version inc patch`
    Then the output should contain "0.0.1"

  Scenario: Incrementing major version resets minor and patch
    Given I run `version inc minor`
    And I run `version inc patch`
    And I run `version inc major`

    Then the output should contain "1.0.0"

  Scenario: Incrementing minor version resets patch
    Given I run `version inc major`
    And I run `version inc patch`
    And I run `version inc minor`

    Then the output should contain "1.1.0"

  Scenario: Setting the special field
    Given I run `version special "pre3"`
    Then the output should contain "0.0.0-pre3"

  Scenario: Setting the meta field
    Given I run `version meta 20150129135914`
    Then the output should contain "0.0.0"

    And I run `version tag`
    Then the output should contain "0.0.0+20150129135914"

  Scenario: Setting both meta and special fields
    Given I run `version special "pre3"`
    And I run `version meta 20150129135914`

    Then the output should contain "0.0.0-pre3"

  Scenario: Incrementing major version resets special and meta
    Given I run `version special "pre3"`
    And I run `version meta 20150129135914`
    And I run `version inc major`

    And I run `version tag`
    Then the output should contain "1.0.0"

  Scenario: Incrementing minor version resets special and meta
    Given I run `version special "pre3"`
    And I run `version meta 20150129135914`
    And I run `version inc minor`

    And I run `version tag`
    Then the output should contain "0.1.0"

  Scenario: Incrementing patch level resets special and meta
    Given I run `version special "pre3"`
    And I run `version meta 20150129135914`
    And I run `version inc patch`

    And I run `version tag`
    Then the output should contain "0.0.1"
