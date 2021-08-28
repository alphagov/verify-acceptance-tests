Feature: User registers, returns to confirm identity and signs in successfully

  This tests user non-repudiation flow.

  Scenario: User registers with documents, confirms identity and signs in successfully
    Given the user is at Test RP
    And they start a journey
    And this is their first time using Verify
    And they are above the age threshold
    And they have all their documents
    And they do have a phone
    And they click Continue
    And they continue to register with IDP "Stub Idp Demo Two"
    And they submit user details:
          | firstname       | Jane       |
          | surname         | Doe        |
          | addressLine1    | 123        |
          | addressLine2    | Test Drive |
          | addressTown     | Marlbury   |
          | addressPostCode | ABC 123    |
          | dateOfBirth     | 1987-03-03 |
    Then the consent page should show level of assurance "LEVEL_2"
    When they give their consent
    And they click Continue
    Then they should be successfully verified
    When they click button "Confirm Identity"
    Then they should arrive at the confirm identity page
    When they click button "Sign in with Stub Idp Demo Two"
    And they login as "the newly registered user"
    Then they should be successfully verified with level of assurance "LEVEL_2"
