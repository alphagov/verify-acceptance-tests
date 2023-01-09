#Feature: Journey hint takes user to correct page
#
#  Test that when a journey hint is supplied the user is taken
#  to the appropriate page.
#
#  Scenario: Journey hint Sign-in with Verify
#    Given the user is at Test RP
#    And they select journey hint "Sign-in with Verify"
#    And they start a journey
#    Then they should arrive at the start page
