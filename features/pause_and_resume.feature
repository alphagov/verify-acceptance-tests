@PauseAndResume
Feature: Pause and Resume User Journey

  This tests the pause and resume user journeys.

  Scenario: User pauses registration, bookmarks and revisits (on same device with cookies in place) the paused page and resumes from registration
    Given the user is at Test RP
    And they start a registration journey with IDP "Stub Idp Demo Two"
    And they choose to pause their journey
    Then they will be at the stateful paused page for "Stub Idp Demo Two"

    When they visit the paused page
    Then they will be at the stateful paused page for "Stub Idp Demo Two"

    When they continue verifying with "Stub Idp Demo Two"
    Then they will be at the resume page for "Stub Idp Demo Two"

    When they resume registering with IDP "Stub Idp Demo Two"
    And they click on link "Register"
    And they submit user details:
        | firstname       | Jane       |
        | surname         | Doe        |
        | addressLine1    | 123        |
        | addressLine2    | Test Drive |
        | addressTown     | Marlbury   |
        | addressPostCode | ABC 123    |
        | dateOfBirth     | 1987-03-03 |
    When they give their consent
    Then they should be successfully verified

  Scenario: User pauses registration, bookmarks and revisits the paused page (after session timeout) and resumes from registration
    Given the user is at Test RP
    And they start a registration journey with IDP "Stub Idp Demo Two"
    And they choose to pause their journey
    Then they will be at the stateful paused page for "Stub Idp Demo Two"

    Given frontend session times out
    When they visit the paused page
    Then they will be at the stateful paused page for "Stub Idp Demo Two"

    When they continue verifying with "Stub Idp Demo Two"
    Then they will be at the resume page for "Stub Idp Demo Two"

    When they resume registering with IDP "Stub Idp Demo Two"
    And they click on link "Register"
    And they submit user details:
      | firstname       | Jane       |
      | surname         | Doe        |
      | addressLine1    | 123        |
      | addressLine2    | Test Drive |
      | addressTown     | Marlbury   |
      | addressPostCode | ABC 123    |
      | dateOfBirth     | 1987-03-03 |
    When they give their consent
    Then they should be successfully verified

  Scenario: User pauses and resumes by starting new journey from RP and resumed registration succeeds
    Given the user is at Test RP
    And they start a registration journey with IDP "Stub Idp Demo Two"
    And they choose to pause their journey
    Then they will be at the stateful paused page for "Stub Idp Demo Two"

    Given the user is at Test RP
    When they click button "Start"
    Then they will be at the resume page for "Stub Idp Demo Two"

    When they resume registering with IDP "Stub Idp Demo Two"
    And they click on link "Register"
    And they submit user details:
      | firstname       | Jane       |
      | surname         | Doe        |
      | addressLine1    | 123        |
      | addressLine2    | Test Drive |
      | addressTown     | Marlbury   |
      | addressPostCode | ABC 123    |
      | dateOfBirth     | 1987-03-03 |
    When they give their consent
    Then they should be successfully verified