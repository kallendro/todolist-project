Feature: User Views Lists
  In order to manage my lists
  As an user
  I want to view all my lists in the system

  Scenario: kelvin views kelvin lists
    Given I am kelvin and have the following lists:
      | subject |
      | testing |
      | hallo   |
      | lalala  |
    When I login as kelvin
    Then I should see only the following lists:
      | List    | Action |        |
      | testing | edit   | delete |
      | hallo   | edit   | delete |
      | lalala  | edit   | delete |

  @wip
  Scenario: user try to view lists without logging in
    Given I am not logged in
    When I go to the homepage
    Then I should be redirected to login page
