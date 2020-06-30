Feature: eIDAS Connector Node Smoke Test - Luxembourg - Integration

    This tests the connection of the UK Connector Node to the Luxembourg Proxy Node

    @ignore
    Scenario: Send a request to sign in with a Luxembourg identity
        Given   the user is at Test RP
        And     they start an eIDAS journey
        And     they select 'eAccess' scheme
        Then    they should arrive at a page with text 'Select the provider of your eID'
        And     the page should not have an error message
