Feature: eidas-connector-node-smoke-test-it-prod

    This tests the Italy connector node

    Scenario: Connector node happy path for Italy
        Given   the user visits a Government service
        And     they choose sign in with a digital identity from another European country
        And     they select Italy
        And     they navigate through Eidas
        Then    they should arrive at the Italy Hub
