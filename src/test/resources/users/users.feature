Feature: JSONPlaceholder Users API

  Background:
    * url 'https://jsonplaceholder.typicode.com'

  Scenario: Get all users returns 10 results
    Given path '/users'
    When method GET
    Then status 200
    And match response == '#[10]'

  Scenario: Get single user by id
    Given path '/users/1'
    When method GET
    Then status 200
    And match response.id == 1
    And match response.name == 'Leanne Graham'
    And match response.email == '#string'

  Scenario: Non-existent user returns 404
    Given path '/users/9999'
    When method GET
    Then status 404
