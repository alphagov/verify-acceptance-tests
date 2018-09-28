Feature: User account creation

  This tests user account creation flows.

  Scenario: Single idp registration
    Given the user is at Stub IDP Demo One
    And they select a service from the list
    And they are sent to Test Rp
    And we do not want to match the user
    And they start a journey
    And they land on the continue to idp page
    And they continue to the idp
    Then they are on Stub IDP Demo One log in
    And they login as "stub-idp-demo-one"
    And they submit cycle 3 "AA123456A"
    Then a user should have been created with details:
      | firstname      | Jack       |
      | surname        | Bauer      |
      | dateofbirth    | 1984-02-29 |
      | currentaddress | 1 Two St   |

