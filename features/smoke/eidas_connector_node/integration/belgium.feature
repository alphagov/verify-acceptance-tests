Feature: eIDAS Connector Node Smoke Test - Belgium - Integration

    This tests the connection of the UK Connector Node to the Belgian Proxy Node

    @ignore
    Scenario: Send a request to sign in with a Belgian identity
        Given   the user is at Test RP
        And     they start an eIDAS journey
        And     they select 'CSAM' scheme
        Then    they should arrive at a page with text 'Choose your digital key to log in'
        And     the page should not have an error message
