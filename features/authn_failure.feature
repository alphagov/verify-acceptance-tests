Feature: User authentication failure

  Scenario: IDP returns authn failure when user Signs in
    Given the user is at Test RP
    When they start a sign in journey
    And they select IDP "Stub Idp Demo Two"
    Then they should be at IDP "Stub Idp Demo Two"

    When they fail sign in with IDP
    Then they should arrive at the failed sign-in page

    When they choose to start again with another IDP
    Then they should arrive at the start page

  Scenario: IDP returns authn failure requester error when user Signs in
    Given the user is at Test RP
    When they start a sign in journey
    And they select IDP "Stub Idp Demo Two"
    Then they should be at IDP "Stub Idp Demo Two"

    When the IDP returns a Requester Error response
    Then they should arrive at the failed sign-in page

    When they choose to start again with another IDP
    Then they should arrive at the start page
