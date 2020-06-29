Feature: eIDAS Connector Node Smoke Test - Spain - Integration

    This tests the connection of the UK Connector Node to the Spanish Proxy Node

    @ignore
    Scenario: Send a request to sign in with an Spanish identity
        Given   the user is at Test RP
        And     they start an eIDAS journey
        And     they select 'DNIe' scheme
        Then    they should arrive at a page with text 'Identificación con DNIe'
        And     the page should not have an error message
