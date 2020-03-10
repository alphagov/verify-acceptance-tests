Feature: eidas-connector-node-smoke-test-be-prod

    This tests the Belgium connector node

    @EidasIntegration
    Scenario: Connector node happy path for Belgium
        Given   the user visits a Government service
        And     they choose sign in with a digital identity from another European country
        And     they select Belgium
        Then    they should arrive at the Belgium Hub
