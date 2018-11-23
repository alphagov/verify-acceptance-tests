Feature: Page to pick between Verify and eIDAS journeys

  Test that a page appears to allow the user to select between
  Verify and eIDAS when there is no journey hint supplied and
  the service has or has not eIDAS enabled.


  Scenario: RP with eIDAS enabled triggers the journey picker
    Given the user is at Test RP
    When they start a journey
    Then they should arrive at the prove identity page

  Scenario: RP without eIDAS enabled doesn't trigger the journey picker
    Given the user is at Test RP
    And we set the RP name to "test-rp-non-eidas"
    When they start a journey
    Then they should arrive at the Start page
