Feature: Project Index

  Scenario: Visiting a project page
    Given I am a logged in average user
    And   I am on the projects index
    When  I click on a project
    Then  I should be redirected to the project's summary page

  Scenario: Searching for a project
    Given I am on the projects index
    And   the database contains certain projects
    When  I type into the search bar
    Then  the displayed projects should change accordingly

  Scenario: Seeing things quickly
    Given I am a average user
    When  I visit the Project Page
    Then  I should see Photos within 2 seconds
