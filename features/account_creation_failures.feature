Feature: User account creation failures

  This tests user account creation flows with failures.

  Scenario: Failed user account creation
    Given the user is at Test RP
    And we set the RP name to "test-rp-noc3"
    And we do not want to match the user
    And we want to fail account creation
    And they start a sign in journey
    And they select IDP "Stub Idp Demo One"
    And they login as "stub-idp-demo-one" with a random pid
    Then should arrive at the user account creation error page
    When they click on link "Other ways to prove your identity online"
    Then they should arrive at the Test RP start page with error notice

