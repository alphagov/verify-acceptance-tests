#Feature: User authentication failure
#
#  This tests authentication and registration failure flows
#
#  Scenario: IDP returns authn failure on registration attempt with LOA2 and RP is not allowed to continue on fail
#    Given the user is at Test RP
#    When they start a journey
#    And this is their first time using Verify
#    And they are above the age threshold
#    Then they should arrive at the about documents page
#
#    When they click Continue
#    And they continue to register with IDP "Stub Idp Demo Two"
#    When the IDP returns an Authn Failure response
#    Then they should arrive at the failed registration page
#
#    When they choose to try another company
#    Then they should arrive at the IDP registration picker page
#
#  Scenario: IDP returns authn failure on registration attempt with LOA1 and RP is not allowed to continue on fail
#    Given the user is at Test RP
#    Given RP name is set to "loa1-test-rp"
#    When they start a journey
#    And this is their first time using Verify
#    Then they should arrive at the IDP registration picker page
#
#    When they continue to register with IDP "Stub Idp Demo Two"
#    Then the IDP returns an Authn Failure response
#    And they should arrive at the failed registration page
#
#    When they choose to try another company
#    Then they should arrive at the IDP registration picker page
#
#  Scenario: IDP returns authn failure when user Signs in
#    Given the user is at Test RP
#    When they start a sign in journey
#    And they select IDP "Stub Idp Demo Two"
#    Then they should be at IDP "Stub Idp Demo Two"
#
#    When they fail sign in with IDP
#    Then they should arrive at the failed sign-in page
#
#    When they choose to start again with another IDP
#    Then they should arrive at the start page
#
#  Scenario: IDP returns authn failure requester error when user Signs in
#    Given the user is at Test RP
#    When they start a sign in journey
#    And they select IDP "Stub Idp Demo Two"
#    Then they should be at IDP "Stub Idp Demo Two"
#
#    When the IDP returns a Requester Error response
#    Then they should arrive at the failed sign-in page
#
#    When they choose to start again with another IDP
#    Then they should arrive at the start page
