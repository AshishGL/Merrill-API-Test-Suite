@login
Feature: Login Process on Stage Server
@start
  Scenario: Login process-Start
    Given I send and accept JSON
    And I add Headers:
      | Accept | application/json |
    When I send a POST request to "https://stage-web.core.merrillcorp.com/start"
    Then the response status should be "200"
  #  And I grab "$..resumePath" as "resumeCode"
  

  @validate
  Scenario: Login Process-Validate
    Given I send and accept JSON
    
    When   I set JSON request body to:
    """
    {
 "password": "Test@1234",
 "username": "ashish.sharma6@globallogic.com"
    }
    """
    And I send a POST request to "https://stage-web.core.merrillcorp.com/auth/validate"
    Then the response status should be "200"
    And  the JSON response should have key "jwt"
    And  the JSON response should have key "userId"
    And I grab "$..jwt" as "token"
    And I grab "$..userId" as "userId"
    
    Scenario: Login Process- Complete
    
    Given I send and accept JSON
    
    When   I set JSON request body to:
    """
    {
    "userId"="{userId}",
    "subject"="ashish.sharma6@globallogic.com",
    "resumeCode"="",
    "jwt"="{token}"

    }
    """
    And I send a POST request to "https://stage-web.core.merrillcorp.com/auth/complete"
    Then the response status should be "200"
    


