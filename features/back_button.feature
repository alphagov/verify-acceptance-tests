Feature: User Back button

  This tests back button flows

  Scenario: User selects an IDP and then goes back to select another
    Given the user is at Test RP
    When they start a sign in journey
    And they select IDP "Stub Idp Demo Two"
    Then they should be at IDP "Stub Idp Demo Two"

    When they choose to go back to the "sign-in" page
    And they select IDP "Stub Idp Demo One"
    Then they should be at IDP "Stub Idp Demo One"
    And they login as "stub-idp-demo-one"
    Then they should be successfully verified


  @Eidas
  Scenario: User selects a Verify IDP and then goes back to select a country
    Given the user is at Test RP
    When they start a sign in journey
    And they select IDP "Stub Idp Demo One"
    Then they should be at IDP "Stub Idp Demo One"

    When they go back to the journey picker page
    And they choose to use a European identity scheme
    Then they should arrive at the country picker

    And they select eIDAS scheme "Stub IDP Demo"
    Then they should be at IDP "Stub Country"
    And they login as "stub-country"
    Then they should be successfully verified


  @Eidas
  Scenario: User selects a country and then goes back to select a Verify IDP
    Given the user is at Test RP
    When they start an eIDAS journey
    Then they should arrive at the country picker
    And they select eIDAS scheme "Stub IDP Demo"
    Then they should be at IDP "Stub Country"

    When they go back to the journey picker page
    And they choose to use Verify
    Then they should arrive at the Start page
    And they select sign in option

    And they select IDP "Stub Idp Demo One"
    Then they should be at IDP "Stub Idp Demo One"
    And they login as "stub-idp-demo-one"
    Then they should be successfully verified


  Scenario: User selects sign in then goes back to select registration
    Given the user is at Test RP
    When they start a sign in journey
    And they select IDP "Stub Idp Demo Two"
    Then they should be at IDP "Stub Idp Demo Two"

    When they choose to go back to the "sign-in" page
    Then they should arrive at the Sign in page

    When they choose to go back to the "start" page
    Then they should arrive at the Start page

    When they choose a registration journey
    Then they should arrive at the Select documents page

    And they have all their documents
    And they do not have a phone
    And they continue to register with IDP "Stub Idp Demo One"
    And they want to cancel registration
    Then they should arrive at the "Stub Idp Demo One" Cancel Registration page

