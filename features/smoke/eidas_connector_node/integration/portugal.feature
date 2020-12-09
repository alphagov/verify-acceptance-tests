Feature: eIDAS Connector Node Smoke Test - Portugal - Integration

    This tests the connection of the UK Connector Node to the Portuguese Proxy Node

    @Eidas
    Scenario: Send a request to sign in with a Portuguese identity
        Given   the user is at Test RP
        And     they start an eIDAS journey
        And     they select 'Autenticação.gov' scheme
        Then    they should arrive at a page with text 'FAÇA A SUA AUTENTICAÇÃO COM'
        And     the page should not have an error message
