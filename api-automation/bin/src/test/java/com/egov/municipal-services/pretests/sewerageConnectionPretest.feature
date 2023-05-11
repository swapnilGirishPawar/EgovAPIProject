Feature: Sewerage Connection service pretests

Background:
    * def sewerageCreateRequest = read('../../municipal-services/requestPayload/sewerage-connection/create.json')
    * def sewerageSearchRequest = read('../../municipal-services/requestPayload/sewerage-connection/update.json')
    * def sewerageUpdateRequest = read('../../municipal-services/requestPayload/sewerage-connection/search.json')

@successSewerageCreate
Scenario: success sewerage connection create 
  Given url createSewerageConnection 
  And request sewerageCreateRequest
  When method post
  Then status 200
  And def sewerageResponseHeader = responseHeaders
  And def sewerageResponseBody = response
  And def sewerageConnection = sewerageResponseBody.SewerageConnections[0]
  And def sewerageConnectionApplicationId = sewerageConnection.applicationNo
  And def sewerageConnectionNumber = sewerageConnection.connectionNo
  And def sewerageConnectionApplicationNumber = sewerageResponseBody.SewerageConnections[0].applicationNo
  And def sewerageConnectionId = sewerageConnection.id

@sewerageCreateInvalidSewerageConnection
Scenario: sewerage connection create - Invalid Property ID
  Given url createSewerageConnection 
  And request sewerageCreateRequest
  When method post
  # * print response
  # * print responseStatus
  And def sewerageResponseHeader = responseHeaders
  And def sewerageResponseBody = response

@searchSewerageConnectionSuccessfully
Scenario: Search a Sewerage Connection with Valid Parameters
	Given  url searchSewerageConnection 
	And params searchSewerageConnectionParams
  # * print searchSewerageConnectionParams
	And request searchPropertyRequest
	When method post
	Then status 200 
        # * print response
	And def sewerageResponseHeader = responseHeaders 
	And def sewerageResponseBody = response
  And def sewerageConnection = sewerageResponseBody.SewerageConnections[0]
  And def sewerageConnectionNumber = sewerageConnection.connectionNo
  And def sewerageConnectionApplicationStatus = sewerageConnection.applicationStatus

@searchSewerageConnectionInvalidParameters
Scenario: Search a Sewerage Connection with InValid Parameters
	Given  url searchSewerageConnection 
	And params searchSewerageConnectionParams
	And request searchPropertyRequest
	When method post
        # * print response
  And def sewerageResponseHeader = responseHeaders 
	And def sewerageResponseBody = response

@UpdateSewerageConnectionSuccessfully
Scenario: Search a Sewerage Connection with Valid Parameters
  * eval sewerageUpdateRequest.SewerageConnection = sewerageConnection
  * eval sewerageUpdateRequest.SewerageConnection.processInstance.action = processInstanceAction
  * eval sewerageUpdateRequest.SewerageConnection.roadCuttingInfo = roadCuttingInfo
  * eval sewerageUpdateRequest.SewerageConnection.connectionType = sewerageConnectionType
  * eval sewerageUpdateRequest.SewerageConnection.connectionExecutionDate = connectionExecutionDate
	Given  url updateSewerageConnection 
	#And params searchSewerageConnectionParams
	And request sewerageUpdateRequest
	When method post
	Then status 200 
        # * print response
	And def sewerageResponseHeader = responseHeaders 
	And def sewerageResponseBody = response
  And def sewerageConnection = sewerageResponseBody.SewerageConnections[0]
  And def sewerageConnectionApplicationNumber = sewerageResponseBody.SewerageConnections[0].applicationNo

@UpdateSewerageConnectionWithApplicationNumber
Scenario: Update a Sewerage Connection with invalid Parameters
  * eval sewerageUpdateRequest.SewerageConnection = sewerageConnection
  * eval sewerageUpdateRequest.SewerageConnection.applicationNo = sewerageConnectionApplicationId
	Given  url updateSewerageConnection 
	And request sewerageUpdateRequest
	When method post
	Then status 200 
    # * print response
	And def sewerageResponseHeader = responseHeaders 
	And def sewerageResponseBody = response
  And def sewerageConnection = sewerageResponseBody.SewerageConnections[0]
  