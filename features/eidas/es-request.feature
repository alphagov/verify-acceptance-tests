Feature: eidas-connector-node-smoke-test-es-prod

    This tests the Spain connector node

    Scenario: Connector node happy path for Spain
        Given   the user visits a Government service
        And     they choose sign in with a digital identity from another European country
        And     they select Spain
        Then    they should arrive at the Spain Hub
