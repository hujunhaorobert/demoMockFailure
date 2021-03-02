Feature: stateful mock server
Background:
    * print "Run background only once..."
    * def curId = 0
    * call read('karate-config.js')
    * call read('utils/utils.feature')    

Scenario: pathMatches('/greeting')
    * def datetime = getDateTime()
    * string text = 'Hello, ' + env + ' Karate Mock Server is alive in ' + server + '!'
    * def response = { id: '#(nextId())', timestamp: '#(datetime)', message: '#(text)' }

Scenario:
   * def responseStatus = 404
   * def response =  { 'ErrorMessage': 'Not Found' }

