Feature: eidas-connector-node-smoke-test-be-prod

    This tests the connection of the UK Connector Node to the Belgian Proxy Node

    @EidasIntegration
    Scenario: Send a request to sign in with a Belgian identity
        Given   the user visits a UK Government service
        And     they choose to sign in with a digital identity from another European country
        And     they select Belgium
        Then    they should arrive at the Belgium Hub
