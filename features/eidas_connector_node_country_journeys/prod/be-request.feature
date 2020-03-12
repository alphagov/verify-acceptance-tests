Feature: eidas-connector-node-smoke-test-be-prod

    This tests the connection of the UK Connector Node to the Belgian Proxy Node

    @ignore
    Scenario: Send a request to sign in with a Belgian identity
        Given   the user visits a UK Government service
        And     they choose to sign in with a digital identity from another European country
        And     they select 'CSAM' scheme
        Then    they should arrive at a page with text 'Choose your digital key to log in'
        And     the page should not have an error message
