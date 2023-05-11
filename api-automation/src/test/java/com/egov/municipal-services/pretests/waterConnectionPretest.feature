Feature: Water Connection service pretests

Background:
    * def jsUtils = read('classpath:com/egov/utils/jsUtils.js')
    * def createWaterConnectionRequest = read('../../municipal-services/requestPayload/water-connection/create.json')
    * def updateWaterConnectionRequest = read('../../municipal-services/requestPayload/water-connection/update.json')
    * def searchWaterConnectionRequest = read('../../municipal-services/requestPayload/water-connection/search.json')

@successCreateWaterConnection
Scenario: Create water connection successfully
    Given url createWaterConnection
    And request createWaterConnectionRequest
    # * print createWaterConnectionRequest
	When method post 
	Then status 200
	And def waterConnectionResponseHeaders = responseHeaders 
	And def waterConnectionResponseBody = response
    And def WaterConnection = waterConnectionResponseBody.WaterConnection[0]
    And def waterConnectionId = WaterConnection.id
    And def waterConnectionApplicationNo = WaterConnection.applicationNo
    # * print 'Application Number: ' + waterConnectionApplicationNo

@errorInCreateWaterConnection
Scenario: Create water connection error
    Given url createWaterConnection
    And request createWaterConnectionRequest 
	When method post 
	Then status 400
	And def waterConnectionResponseHeaders = responseHeaders 
	And def waterConnectionResponseBody = response

@errorInCreateWaterConnectionWithInvalidTenantId
Scenario: Create water connection error with invalid tenantId
    Given url createWaterConnection
    * eval createWaterConnectionRequest.WaterConnection.tenantId = 'invalid-tenant-' + randomString(5)
    And request createWaterConnectionRequest 
	When method post 
	Then status 400
	And def waterConnectionResponseHeaders = responseHeaders 
	And def waterConnectionResponseBody = response

@successSearchWaterConnection
Scenario: Search water connection successfully
    Given url searchWaterConnection
    And params waterConnectionParams
    # * print waterConnectionParams
    And request searchWaterConnectionRequest 
    # * print searchWaterConnectionRequest
	When method post
    Then status 200
    And def waterConnectionResponseHeaders = responseHeaders 
	And def waterConnectionResponseBody = response
    And def WaterConnection = waterConnectionResponseBody.WaterConnection[0]
    And def waterConnectionId = WaterConnection.id
    And def waterConnectionApplicationNo = WaterConnection.applicationNo
    And def waterConnectionApplicationStatus = WaterConnection.applicationStatus

@errorInSearchWaterConnection
Scenario: Search water connection error
    Given url searchWaterConnection
    And params waterConnectionParams
    And request searchWaterConnectionRequest 
	When method post
    Then status 400
    And def waterConnectionResponseHeaders = responseHeaders 
	And def waterConnectionResponseBody = response

@successUpdateWaterConnection
Scenario: Update Water connection successfully
    * eval updateWaterConnectionRequest.WaterConnection = WaterConnection
    * eval updateWaterConnectionRequest.WaterConnection.processInstance.action = processInstanceAction
    Given url updateWaterConnection
    And request updateWaterConnectionRequest 
    # * print updateWaterConnectionRequest
	When method post
    # * print response
    Then status 200
    And def waterConnectionResponseHeaders = responseHeaders 
	And def waterConnectionResponseBody = response
    And def WaterConnection = waterConnectionResponseBody
    And def WaterConnection = waterConnectionResponseBody.WaterConnection[0]
    And def waterConnectionId = WaterConnection.id
    And def waterConnectionApplicationNo = WaterConnection.applicationNo

@errorInUpdateWaterConnection
Scenario: Update Water connection error
    * eval updateWaterConnectionRequest.WaterConnection = WaterConnection
    * eval updateWaterConnectionRequest.WaterConnection.processInstance.action = processInstanceAction
    Given url updateWaterConnection
    And request updateWaterConnectionRequest 
	When method post
    Then status 400
    And def waterConnectionResponseHeaders = responseHeaders 
	And def waterConnectionResponseBody = response