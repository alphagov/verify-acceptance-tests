Feature: Journey hint takes user to correct page

  Test that when a journey hint is supplied the user is taken 
  to the appropriate page.

  Scenario: Journey hint Registration
    Given the user is at Test RP
    And they select journey hint "Registration"
    And they start a journey
    Then they arrive at the about page

  Scenario: Journey hint Sign-in with Verify
    Given the user is at Test RP
    And they select journey hint "Sign-in with Verify"
    And they start a journey
    Then they arrive at the IDP sign-in page

  @Eidas
  Scenario: Journey hint Sign-in with eIDAS
    Given the user is at Test RP
    And they select journey hint "Sign-in with eIDAS"
    And they start a journey
    Then they should arrive at the country picker page
