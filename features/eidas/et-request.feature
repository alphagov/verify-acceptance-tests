Feature: eidas-connector-node-smoke-test-et-prod

    This tests the Estonia connector node

    Scenario: Connector node happy path for Estonia
        Given   the user visits a Government service
        And     they choose sign in with a digital identity from another European country
        And     they select Estonia
        And     they navigate through Eidas
        Then    they should arrive at the Estonia Hub
