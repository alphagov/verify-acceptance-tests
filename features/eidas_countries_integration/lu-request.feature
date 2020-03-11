Feature: eidas-connector-node-smoke-test-lu-prod

    This tests the connection of the UK Connector Node to the Luxembourg Proxy Node

    @EidasIntegration
    Scenario: Send a request to sign in with a Luxembourg identity
        Given   the user visits a UK Government service
        And     they choose to sign in with a digital identity from another European country
        And     they select Luxembourg
        Then    they should arrive at the Luxembourg Hub
