Feature: Compatibility with old supported MSA versions
  These tests check that the hub works correctly with old supported
  MSA versions.

  Scenario Outline: Sign in successful with IDP and cycle 3
    Given the user is at "<RP>"
    And they start a sign in journey
    And they select IDP "Stub Idp Demo Two"
    And they login as "stub-idp-demo-two-c3"
    And they submit cycle 3 "AA123456A"
    Then they should be successfully verified

  Examples:
    | RP                                                              |
    | https://test-rp-staging-backcompat-3.cloudapps.digital/test-rp/ | # Version 4.2.1-901
    | https://test-rp-staging-backcompat-4.cloudapps.digital/test-rp/ | # Version 5.0.2-5.0.2
    | https://test-rp-staging-backcompat-5.cloudapps.digital/test-rp/ | # Version 5.1.0-5.1.0
