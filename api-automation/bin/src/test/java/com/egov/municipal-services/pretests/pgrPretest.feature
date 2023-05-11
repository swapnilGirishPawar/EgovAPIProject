Feature: PGR Service Pretest

Background:
    * def createPGRRequest = read('../../municipal-services/requestPayload/pgr-service/create.json')
    * def updatePGRRequest = read('../../municipal-services/requestPayload/pgr-service/update.json')
    * def searchPGRRequest = read('../../municipal-services/requestPayload/pgr-service/search.json')
    * def countPGRRequest = read('../../municipal-services/requestPayload/pgr-service/count.json')

@successCreatePGRRequest
Scenario: Create PGR Request successfully
    Given url createPGRUrl
    And request createPGRRequest 
    # * print createPGRRequest
    When method post 
    Then status 200
    And def pgrResponseHeaders = responseHeaders 
    And def pgrResponseBody = response
    # * print pgrResponseBody
    And def serviceDetails = pgrResponseBody.ServiceWrappers[0].service
    And def serviceRequestId = pgrResponseBody.ServiceWrappers[0].service.serviceRequestId


@failCreatePGRRequest
Scenario: Create PGR Request With Failure
    Given url createPGRUrl
    And request createPGRRequest 
    When method post 
    # * print response
    Then status 400
    # * print response
    And def pgrResponseHeaders = responseHeaders 
    And def pgrResponseBody = response

@failCreatePGRRequestUnAuthorized
Scenario: Create PGR Request With Failure
    Given url createPGRUrl
    And request createPGRRequest 
    When method post 
    # * print response
    Then status 403
    # * print response
    And def pgrResponseHeaders = responseHeaders 
    And def pgrResponseBody = response

@successfullyUpdatePGRRequest
Scenario: Update PGR Request successfully
    Given url updatePGRUrl
    And request updatePGRRequest 
    # * print updatePGRRequest
    When method post 
    # * print response
    Then status 200
    And def pgrResponseHeaders = responseHeaders 
    And def pgrResponseBody = response
    # And def serviceDetails = pgrResponseBody.ServiceWrappers[0].service
    # And def serviceRequestId = pgrResponseBody.ServiceWrappers[0].service.serviceRequestId
@failUpdatePGRRequest
Scenario: Update PGR Request successfully
    Given url updatePGRUrl
    And request updatePGRRequest 
    # * print updatePGRRequest
    When method post 
    # * print response
    Then status 400
    And def pgrResponseHeaders = responseHeaders 
    And def pgrResponseBody = response 

@failUpdatePGRRequestAuthorized
Scenario: Update PGR Request successfully
    Given url updatePGRUrl
    And request updatePGRRequest 
    # * print updatePGRRequest
    When method post 
    # * print response
    Then status 403
    And def pgrResponseHeaders = responseHeaders 
    And def pgrResponseBody = response 

@successfullySearchPGRRequest
Scenario: Search PGR Request successfully
    Given url searchPGRUrl
    And request searchPGRRequest
    And params searchPGRParams 
    # * print searchPGRRequest
    # * print searchPGRParams
    When method post 
    # * print response
    Then status 200
    And def pgrResponseHeaders = responseHeaders 
    And def pgrResponseBody = response
    And def serviceDetails = pgrResponseBody.ServiceWrappers[0].service
    And def serviceRequestId = pgrResponseBody.ServiceWrappers[0].service.serviceRequestId

@errorSearchPGRRequestwithInvalidTenantId
Scenario: Fail Search PGR Request
    Given url searchPGRUrl
    And request searchPGRRequest
    And params searchPGRParams 
    # * print searchPGRRequest
    When method post 
    # * print response
    Then status 400
    And def pgrResponseHeaders = responseHeaders 
    And def pgrResponseBody = response  

@successfullyCountPGRRequestWithParams
Scenario: Count PGR Request successfully
    Given url countPGRUrl
    And request countPGRRequest
    And params countPGRParams 
    # * print searchPGRRequest
    When method post 
    # * print response
    Then status 200
    And def pgrResponseHeaders = responseHeaders 
    And def pgrResponseBody = response

@successfullyCountPGRRequest
Scenario: Count PGR Request successfully
    Given url countPGRUrl
    And request countPGRRequest
    # * print searchPGRRequest
    When method post 
    # * print response
    Then status 200
    And def pgrResponseHeaders = responseHeaders 
    And def pgrResponseBody = response

@failCountPGRRequest
Scenario: Count PGR Request With Invalid Params
    Given url countPGRUrl
    And request countPGRRequest
    And params countPGRParams
    # * print countPGRParams
    When method post
    # * print response
    Then status 403
    And def pgrResponseHeaders = responseHeaders 
    And def pgrResponseBody = response

