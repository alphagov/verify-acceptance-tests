Feature: eidas-connector-node-smoke-test-lu-prod

    This tests the Luxembourg connector node

    Scenario: Connector node happy path for Luxembourg
        Given   the user visits a Government service
        And     they choose sign in with a digital identity from another European country
        And     they select Luxembourg
        Then    they should arrive at the Luxembourg Hub
