Feature: eIDAS user journeys with user account creation

  This tests eIDAS end-to-end journeys involving a new user account creation.

  @Eidas
  Scenario: User registers with stub country, with cycle3 and forces UAC
    Given the user is at Test RP
    And we do not want to match the user
    And they start an eIDAS journey
    And they select IDP "Stub IDP Demo"
    And they click Register
    And they enter eidas user details:
      | firstname   | Bob        |
      | surname     | Doe        |
      | dateOfBirth | 1987-03-03 |
    And they submit cycle 3 "AA123456A"
    Then a user should have been created with details:
      | firstname   | Bob        |
      | surname     | Doe        |
      | dateofbirth | 1987-03-03 |

  @Eidas
  Scenario: User signs and creates a new account
    Given the user is at Test RP
    And we do not want to match the user
    And they start an eIDAS journey
    And they select IDP "Stub IDP Demo"
    And they login as "stub-country"
    And they submit cycle 3 "AA123456A"
    Then a user should have been created with details:
      | firstname   | Jack       |
      | surname     | Bauer      |
      | dateofbirth | 1984-02-29 |

  @Eidas
  Scenario: User registers with stub country, for unsigned assertions, with cycle3, and forces UAC
    Given the user is at Test RP
    And we do not want to match the user
    And they start an eIDAS journey
    And they select IDP "Stub IDP Demo"
    And they choose unsigned assertions
    And they click Register
    And they enter eidas user details:
      | firstname   | Bob        |
      | surname     | Doe        |
      | dateOfBirth | 1987-03-03 |
    And they submit cycle 3 "AA123456A"
    Then a user should have been created with details:
      | firstname   | Bob        |
      | surname     | Doe        |
      | dateofbirth | 1987-03-03 |

  @Eidas
  Scenario: User signs in and creates a new account with stub country, for unsigned assertions
    Given the user is at Test RP
    And we do not want to match the user
    And they start an eIDAS journey
    And they select IDP "Stub IDP Demo"
    And they choose unsigned assertions
    And they login as "stub-country"
    And they submit cycle 3 "AA123456A"
    Then a user should have been created with details:
      | firstname   | Jack       |
      | surname     | Bauer      |
      | dateofbirth | 1984-02-29 |
