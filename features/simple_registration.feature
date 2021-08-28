Feature: User simple flows - registration

  These tests user simple registration flows.

  Scenario: User cannot register with a disconnected IDP
    Given the user is at Test RP
    And they start a journey
    And this is their first time using Verify
    And they are above the age threshold
    And they click Continue
    Then they cannot continue to register with disconnected IDP "Stub Idp Demo Three"
