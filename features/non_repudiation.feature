Feature: User registers, returns to confirm identity and signs in successfully

  This tests user non-repudiation flow.

  Scenario: User registers, confirms identity and signs in
    Given the user is at Test RP
    And they start a journey
    And this is their first time using Verify
    And they are above the age threshold
    And they have all their documents
    And they have a smart phone
    And they continue to register with IDP "Experian"
    And they submit user details:
          | firstname       | Jane       |
          | surname         | Doe        |
          | addressLine1    | 123        |
          | addressLine2    | Test Drive |
          | addressTown     | Marlbury   |
          | addressPostCode | ABC 123    |
          | dateOfBirth     | 1987-03-03 |
    Then our Consent page should show "Level of assurance" = "LEVEL_2"
    When they give their consent
    Then they should be successfully verified
    When they click button "Confirm Identity"
    Then they arrive at the confirm identity page for "Experian"
    When they click button "Sign in with Experian"
    And they login as the newly registered user
    Then they should be successfully verified
