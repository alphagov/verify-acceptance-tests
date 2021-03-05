Feature: User loa2 loa1

  This tests user loa2 and loa1 flows.

  Scenario: Loa1 Registration successful with IDP
    Given the user is at Test RP
    And we set the RP name to "loa2-loa1-test-rp"
    And they start a journey
    And they choose an loa1 registration journey
    And they register for an LOA1 profile with IDP "Stub Idp Demo One"
    When they submit loa1 user details:
      | firstname       | Jessica    |
      | surname         | Rabbit     |
      | addressLine1    | 1 Two St   |
      | addressLine2    | Wells      |
      | addressTown     | newtown    |
      | addressPostCode | 1A 2BC     |
      | dateOfBirth     | 1960-03-23 |
    Then our Consent page should show "Level of assurance" = "LEVEL_1"
    When they give their consent
    And they click continue on the confirmation page
    Then they should be successfully verified with level of assurance "LEVEL_1"

  Scenario: LOA2 Registration with cycle 3
    Given the user is at Test RP
    And we set the RP name to "loa2-loa1-test-rp"
    And we do not want to match the user
    And they start a journey
    And they choose an loa1 registration journey
    And they continue to register with IDP "Stub Idp Demo One"
    And they submit user details:
      | firstname       | Jane       |
      | surname         | Doe        |
      | addressLine1    | 123        |
      | addressLine2    | Test Drive |
      | addressTown     | Marlbury   |
      | addressPostCode | ABC 123    |
      | dateOfBirth     | 1987-03-03 |
    When they give their consent
    And they click continue on the confirmation page
    And they submit cycle 3 "AA123456A"
    Then a user should have been created with details:
      | firstname      | Jane           |
      | surname        | Doe            |
      | dateofbirth    | 1987-03-03     |
      | currentaddress | 123 Test Drive |

  Scenario: Sign in successful at LOA1 with IDP
    Given the user is at Test RP
    And we set the RP name to "loa2-loa1-test-rp"
    When they start a sign in journey
    And they select IDP "Stub Idp Demo One"
    And they login as "stub-idp-demo-one-loa1"
    Then they should be successfully verified with level of assurance "LEVEL_1"

  Scenario: Sign in successful at LOA2 with IDP
    Given the user is at Test RP
    And we set the RP name to "loa2-loa1-test-rp"
    When they start a sign in journey
    And they select IDP "Stub Idp Demo One"
    And they login as "stub-idp-demo-one"
    Then they should be successfully verified with level of assurance "LEVEL_2"
