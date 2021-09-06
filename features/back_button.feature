Feature: User Back button

  This tests back button flows

  Scenario: User selects an IDP and then goes back to select another
    Given the user is at Test RP
    When they start a sign in journey
    And they select IDP "Stub Idp Demo Two"
    Then they should be at IDP "Stub Idp Demo Two"

    When they go back to the IDP sign-in picker page
    And they select IDP "Stub Idp Demo One"
    Then they should be at IDP "Stub Idp Demo One"
    And they login as "stub-idp-demo-one"
    Then they should be successfully verified

  Scenario: User selects sign in then goes back to select registration
    Given the user is at Test RP
    When they start a sign in journey
    And they select IDP "Stub Idp Demo Two"
    Then they should be at IDP "Stub Idp Demo Two"

    When they go back to the IDP sign-in picker page
    Then they should arrive at the IDP sign-in picker page

    When they go back to the start page
    Then they should arrive at the start page

    When they choose a registration journey
    Then they should arrive at the about documents page

    And they click Continue
    And they continue to register with IDP "Stub Idp Demo Two"
    And they want to cancel registration
    Then they should arrive at the cancelled registration page
