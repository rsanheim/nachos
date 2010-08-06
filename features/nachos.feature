Feature: General diagnostic info
  In order to something something
  A user something something
  something something something

  Scenario: Displaying user info
    Given I am locally configured for Github as "john-doe"
    When I execute nachos "info"
    Then I should see "You are running nachos as john-doe"
    And the exit status should be 0

  Scenario: Syncing watched repos
    Given I am locally configured for Github as "john-doe"
    And I have "3" watched repositories on Github
    And I expect nachos to clone all watched repositories
    When I execute nachos "sync"
    Then the exit status should be 0
    And the stdout should contain "About to sync 3 repositories"
    
  @announce @wip
  Scenario: Syncing watched repos when some are already cloned
    Given I am locally configured for Github as "john-doe"
    And I have a watched repo named "jdoe/twitter" that is cloned locally
    And I have a watched repo named "rspec/rspec" that is not cloned locally
    And I expect nachos to fetch "jdoe/twitter"
    And I expect nachos to clone "rspec/rspec"
    When I execute nachos "sync"
    Then the exit status should be 0

