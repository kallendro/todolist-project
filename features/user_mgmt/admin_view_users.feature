Feature: Admin Views Users
  In order to manage users
  As an admin
  I want to view all users in the system

  Scenario: Admin views users lists
    Given I have users: 
      | username | password | firstname | lastname | dob        |
      | jane     | jane123  | Jane      | Lee      | 01-01-1980 |
      | mary     | mary123  | Mary      | France   | 02-02-1979 |
      | john     | john123  | John      | Woo      | 03-03-1978 |
    When I go to users index page
    Then I should see users: 
      | username |  first name | last name | date of birth | Action|       |
      | jane     |  Jane       | Lee       | 01-01-1980    | edit  |delete |
      | mary     |  Mary       | France    | 02-02-1979    | edit  |delete |
      | john     |  John       | Woo       | 03-03-1978    | edit  |delete |
