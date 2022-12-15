Feature: User loa2 loa1

  This tests user loa2 and loa1 flows.

  Scenario: Sign in successful at LOA1 with IDP
    Given the user is at Test RP
    And RP name is set to "loa2-loa1-test-rp"
    When they start a sign in journey
    And they select IDP "Stub Idp Demo One"
    And they login as "stub-idp-demo-one-loa1"
    Then they should be successfully verified with level of assurance "LEVEL_1"

  Scenario: Sign in successful at LOA2 with IDP
    Given the user is at Test RP
    And RP name is set to "loa2-loa1-test-rp"
    When they start a sign in journey
    And they select IDP "Stub Idp Demo One"
    And they login as "stub-idp-demo-one"
    Then they should be successfully verified with level of assurance "LEVEL_2"
