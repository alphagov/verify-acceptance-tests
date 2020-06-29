Feature: eIDAS Connector Node Smoke Test - Italy - Integration

    This tests the connection of the UK Connector Node to the Italian Proxy Node

    @ignore
    Scenario: Send a request to sign in with an Italian identity
        Given   the user is at Test RP
        And     they start an eIDAS journey
        And     they select 'SPID' scheme
        And     they navigate through the eIDAS CEF reference implementation node
        Then    they should arrive at a page with text 'Italian eIDAS Login'
        And     the page should not have an error message
