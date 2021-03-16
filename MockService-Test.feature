  
Feature: Demo url failure

Background:
    * url mockServerHost
    * callonce read('classpath:utils/utils.feature')
 
Scenario: #1 call greeting API

    Given path '/greeting'
    When method get
    Then status 200

Scenario: #2 call greeting API again
    Given path '/greeting'
    When method get
    Then status 200