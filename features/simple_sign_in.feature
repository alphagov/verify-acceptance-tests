Feature: User simple flows - sign in

  These tests user simple sign in flows.

  Scenario: Sign in successful with IDP and cycle 3
    Given the user is at Test RP
    And they start a sign in journey
    And they select IDP "Stub Idp Demo Two"
    And they login as "stub-idp-demo-two-c3"
    And they submit cycle 3 "AA123456A"
    Then they should be successfully verified

  Scenario: User cannot sign in using a disconnected IDP
    Given the user is at Test RP
    And they start a sign in journey
    Then they cannot sign in with IDP "Stub Idp Disconnected"

  Scenario: User can see disconnected IDP hint
    Given the user is at Test RP
    And they start a registration journey with IDP "Stub Idp Disconnected"
    And they submit user details:
      | firstname       | Jane       |
      | surname         | Doe        |
      | addressLine1    | 123        |
      | addressLine2    | Test Drive |
      | addressTown     | Marlbury   |
      | addressPostCode | ABC 123    |
      | dateOfBirth     | 1987-03-03 |
    And they finish registering
    And the user is at Test RP
    And they start a sign in journey
    Then they should see the disconnected IDP hint for "Stub Idp Disconnected"

  Scenario: Sign in without cycle 3 and unsigned by hub
    Given the user is at Test RP
    And RP name is set to "test-rp-not-signed-by-hub"
    And we do not want to match the user
    And they start a sign in journey
    And they select IDP "Stub Idp Demo One"
    And they login as "stub-idp-demo-one"
    Then a user should have been created with details:
      | firstname   | Jack       |
      | surname     | Bauer      |
      | dateofbirth | 1984-02-29 |
