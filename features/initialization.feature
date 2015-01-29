Feature: Command Line Initialization
  The command line interface should support initializing version stores and
  enforce consistency.

  Background:
    Given I have a project called "project"

  Scenario: Project with no version number
    Given I run `version`
    Then the exit status should be 1

  Scenario: Initialize versioning on a project
    Given I run `version init`
    Then the exit status should be 0

    When I run `version`
    Then the output should contain "0.0.0"

  Scenario: Don't initialize if the project already contains version information
    Given I run `version init`
    Then the exit status should be 0

    When I run `version init`
    Then the exit status should be 1
