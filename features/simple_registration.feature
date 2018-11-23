Feature: User simple flows - registration

  These tests user simple registration flows.

  Scenario: User registers with no documents
    Given the user is at Test RP
    And they start a journey
    And this is their first time using Verify
    And they are above the age threshold
    And they do not have their documents
    And they do not have other identity documents
    And they have a smart phone
    And they continue to register with IDP "Stub Idp Demo Two"
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
    Then they should be successfully verified

  Scenario: User cannot register with a disconnected IDP
    Given the user is at Test RP
    And they start a journey
    And this is their first time using Verify
    And they are above the age threshold
    And they have all their documents
    And they have a smart phone
    Then they cannot continue to register with disconnected IDP "Stub Idp Demo Three"
