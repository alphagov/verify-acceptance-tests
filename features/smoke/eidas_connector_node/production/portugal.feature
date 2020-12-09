Feature: eIDAS Connector Node Smoke Test - Portugal - Production

    This tests the connection of the UK Connector Node to the Portuguese Proxy Node

    @Eidas
    Scenario: Send a request to sign in with a Portuguese identity
        Given   the user visits a UK Government service
        And     they choose to sign in with a digital identity from another European country
        And     they select 'Autenticação.gov' scheme
        Then    they should arrive at a page with text 'FAÇA A SUA AUTENTICAÇÃO COM'
        And     the page should not have an error message
