Feature: eIDAS Connector Node Smoke Test - Estonia - Integration

    This tests the connection of the UK Connector Node to the Estonian Proxy Node

    @ignore
    Scenario: Send a request to sign in with an Estonian identity
        Given   the user is at Test RP
        And     they start an eIDAS journey
        And     they select 'ID-kaart' scheme
        And     they navigate through the eIDAS CEF reference implementation node
        And     they click button "ENGLISH"
        Then    they should arrive at a page with text 'Secure authentication in e-Services of EU member states'
        And     the page should not have an error message
        And     they click button "Mobile-ID"
        And     they provide details:
                    | Personal code | 60001019906 |
                    | Phone number  | 00000766    |
        And     they click button "Continue"
        Then    they should arrive at a page with text "Person identified"
        And     they click button "Return to service provider"
        And     they click button "Submit"
        Then    they should be successfully verified with level of assurance "LEVEL_2"
