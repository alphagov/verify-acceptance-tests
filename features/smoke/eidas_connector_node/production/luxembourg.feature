Feature: eIDAS Connector Node Smoke Test - Luxembourg - Production

    This tests the connection of the UK Connector Node to the Luxembourg Proxy Node

    @ignore
    Scenario: Send a request to sign in with a Luxembourg identity
        Given   the user visits a UK Government service
        And     they choose to sign in with a digital identity from another European country
        And     they select 'eAccess' scheme
        Then    they should arrive at a page with text 'eIDAS Authentication Service'
        And     the page should not have an error message
