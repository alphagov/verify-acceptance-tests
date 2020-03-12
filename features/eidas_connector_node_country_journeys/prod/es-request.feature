Feature: eidas-connector-node-smoke-test-es-prod

    This tests the connection of the UK Connector Node to the Spanish Proxy Node

    @ignore
    Scenario: Send a request to sign in with an Spanish identity
        Given   the user visits a UK Government service
        And     they choose to sign in with a digital identity from another European country
        And     they select Spain
        Then    they should arrive at the Spain Hub
