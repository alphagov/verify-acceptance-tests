Feature: Single IDP journey

  This tests single IDP journey.

  Scenario: Single idp registration
    Given the user is at the "Stub Idp Demo One" prompt page
    When they initiate single IDP journey with serviceID "http://www.test-rp.gov.uk/SAML2/MD" and IDP ID "http://stub_idp.acme.org/stub-idp-demo-one/SSO/POST"
    And they are sent to Test Rp
    And we do not want to match the user
    And they start a journey
    And they land on the continue to idp page
    And they continue to the idp
    Then they should be at IDP "Stub Idp Demo One"
    And they login as "stub-idp-demo-one"
    And they click continue on the confirmation page
    And they submit cycle 3 "AA123456A"
    Then a user should have been created with details:
      | firstname      | Jack       |
      | surname        | Bauer      |
      | dateofbirth    | 1984-02-29 |
      | currentaddress | 1 Two St   |

  Scenario: Single idp registration IDP mangles entity id
    Given the user is at the "Stub Idp Demo One" prompt page
    When they initiate single IDP journey with serviceID "http://www.test-rp.gov.uk/SAML2/MD" and IDP ID "http://stub_idp.acme.org/stub-idp-demo-one/SSO/POST"
    And they are sent to Test Rp
    And we do not want to match the user
    And they start a journey
    And they land on the continue to idp page
    And the entity id is mangled
    And they continue to the idp
    Then they should arrive at the Start page


  Scenario: Single idp registration IDP missing entity id
    Given the user is at the "Stub Idp Demo One" prompt page
    When they initiate single IDP journey with serviceID "http://www.test-rp.gov.uk/SAML2/MD" and IDP ID "http://stub_idp.acme.org/stub-idp-demo-one/SSO/POST"
    And they are sent to Test Rp
    And we do not want to match the user
    And they start a journey
    And they land on the continue to idp page
    And the entity id is missing
    And they continue to the idp
    Then they should arrive at the Start page
