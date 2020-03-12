Feature: eidas-connector-node-smoke-test-et-prod

    This tests the connection of the UK Connector Node to the Estonian Proxy Node

    @ignore
    Scenario: Send a request to sign in with an Estonian identity
        Given   the user visits a UK Government service
        And     they choose to sign in with a digital identity from another European country
        And     they select Estonia
        And     they navigate through the eIDAS CEF reference implementation node
        Then    they should arrive at the Estonia Hub
