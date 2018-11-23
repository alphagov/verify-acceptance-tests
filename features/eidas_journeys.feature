Feature: eIDAS user journeys

  This tests eIDAS end-to-end journeys without an account creation

  @Eidas
  Scenario: User selects a country and then goes back to select another
    Given the user is at Test RP
    And they start an eIDAS journey
    And they select eIDAS scheme "Stub IDP Demo"
    Then they should be at IDP "Stub Country"
    Given they go back to the "country picker" page
    And they select eIDAS scheme "Stub IDP Demo"
    Then they should be at IDP "Stub Country"

  @Eidas
  Scenario: User signs in with a country
    Given the user is at Test RP
    And they start an eIDAS journey
    And they select IDP "Stub IDP Demo"
    And they login as "stub-country"
    Then they should be successfully verified

  @Eidas
  Scenario: User with accents in name signs in
    Given the user is at Test RP
    And they start an eIDAS journey
    And they select IDP "Stub IDP Demo"
    And they login as "stub-country-accents"
    Then they should be successfully verified

  @Eidas
  Scenario: User with non-Latin name signs in
    Given the user is at Test RP
    And they start an eIDAS journey
    And they select IDP "Stub IDP Demo"
    And they login as "stub-country-nonlatin"
    Then they should be successfully verified

  @Eidas
  Scenario: User signs in with a country and does Cycle 3
    Given the user is at Test RP
    And they start an eIDAS journey
    And they select IDP "Stub IDP Demo"
    And they login as "stub-country-ec3"
    And they submit cycle 3 "AA123456A"
    Then they should be successfully verified

  @Eidas
  Scenario: User signs in with a country which responds with rsassa-pss signing algorithm
    Given the user is at Test RP
    And they start an eIDAS journey
    And they select IDP "Stub IDP Demo"
    And they login as "stub-country" with "rsassa-pss" signing algorithm
    Then they should be successfully verified
