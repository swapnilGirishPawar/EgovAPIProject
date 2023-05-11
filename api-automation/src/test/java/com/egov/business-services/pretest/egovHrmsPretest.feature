Feature: HRMS API call

Background:
  * def jsUtils = read('classpath:com/egov/utils/jsUtils.js')
  	# calling localization Json
  * def tenantId = tenantId
  * def createEmployeeRequest = read('../../business-services/requestPayload/egov-hrms/create.json')
  * def searchEmployeeRequest = read('../../business-services/requestPayload/egov-hrms/search.json')
  * def updateEmployeeRequest = read('../../business-services/requestPayload/egov-hrms/update.json')
  * def countEmployeeRequest = read('../../business-services/requestPayload/egov-hrms/count.json')
  * def updateDeactivatemployeeRequest = read('../../business-services/requestPayload/egov-hrms/deactivate.json')
  * configure headers = read('classpath:com/egov/utils/websCommonHeaders.js')

        @createEmployeeSuccessfully
        Scenario: hrms create employee successfully
            Given url hrmsCreateUrl
              And request createEmployeeRequest
             When method post
             Then status 202
              And def hrmsResponseHeader = responseHeaders
              And def hrmsResponseBody = response
              And def Employees = hrmsResponseBody.Employees

        @fetchEmployeeCountSuccessfully
        Scenario: Fetch the employee count
           * def parameters = 
           """
           {
           tenantId: '#(tenantId)'
           }
           """
           Given url hrmsCountUrl
            #* print hrmsCountUrl
            And params parameters
            And request countEmployeeRequest
           When method post
           Then status 200
            And def hrmsResponseBody = response
            #* print hrmsResponseBody
            And def hrmsResponseHeader = responseHeaders
            And def hrmsEmployeeCount = response.EmployeCount
            And def hrmsTotalEmployeeCount = response.EmployeCount.totalEmployee
                  #* print hrmsTotalEmployeeCount
            And def hrmsActiveEmployeeCount = stringToInteger(response.EmployeCount.activeEmployee)
                  #* print hrmsActiveEmployeeCount
            And def hrmsInactiveEmployeeCount = stringToInteger(response.EmployeCount.inactiveEmployee)
                  #* print hrmsInactiveEmployeeCount
            And assert responseStatus == 200


        @createEmployeeError
        Scenario: hrms create employee error
            Given url hrmsCreateUrl
              And request createEmployeeRequest
             When method post
             Then status 400
              And def hrmsResponseHeader = responseHeaders
              And def hrmsResponseBody = response

        @createEmployeeAuthorizationError
        Scenario: hrms create employee error authorization
            Given url hrmsCreateUrl
              And request createEmployeeRequest
             When method post
             Then status 403
              And def hrmsResponseHeader = responseHeaders
              And def hrmsResponseBody = response

        @searchEmployeeSuccessfully
        Scenario: hrms search employee successfully
            Given url hrmsSearchUrl
              And param codes = '#(code)'
              And request searchEmployeeRequest
             When method post
             Then status 200
              And def hrmsResponseHeader = responseHeaders
              And def hrmsResponseBody = response

        @searchEmployeeSuccessfullyWithoutEmployeeCodes
        Scenario: hrms search employee successfully without passing employee codes
            Given url hrmsSearchUrl
              And param tenantId = tenantId
              And request searchEmployeeRequest
             When method post
             Then status 200
              And def hrmsResponseHeader = responseHeaders
              And def hrmsResponseBody = response
  * def employeeCode1 = hrmsResponseBody.Employees[0].code
  * def employeeCode2 = hrmsResponseBody.Employees[1].code

        @searchEmployeeSuccessfullyWithMultipleEmployeeCodes
        Scenario: hrms search employee successfully by passing multiple employee codes
  * def parameters = 
    """
    {
     tenantId: '#(tenantId)',
     codes: '#(code)'
    }
    """
            Given url hrmsSearchUrl
              And params parameters
              And request searchEmployeeRequest
             When method post
             Then status 200
              And def hrmsResponseHeader = responseHeaders
              And def hrmsResponseBody = response

        @searchEmployeeError
        Scenario: hrms search employee error
            Given url hrmsSearchUrl
              And param names = '#(name)'
              And request searchEmployeeRequest
             When method post
             Then status 400
              And def hrmsResponseHeader = responseHeaders
              And def hrmsResponseBody = response

        @searchWithInvalidTenantId
        Scenario: Search employee with Invalid tenant id
            Given url hrmsSearchUrl
              And param tenantId = '#(tenantId)'
              And request searchEmployeeRequest
             When method post
             Then status 403
              And def hrmsResponseHeader = responseHeaders
              And def hrmsResponseBody = response

        @updateEmployeeSuccessfully
        Scenario: hrms update employee successfully
  * eval updateEmployeeRequest.Employees = Employees  
            Given url hrmsUpdateUrl
              And request updateEmployeeRequest
             When method post
             Then status 202
              And def hrmsResponseHeader = responseHeaders
              And def hrmsResponseBody = response

        @updateEmployeeError
        Scenario: hrms update employee error
  * eval updateEmployeeRequest.Employees = Employees 
            Given url hrmsUpdateUrl
              And request updateEmployeeRequest
             When method post
             Then status 400
              And def hrmsResponseHeader = responseHeaders
              And def hrmsResponseBody = response

        @updateEmployeeWithInvalidTenantId
        Scenario: Error in update employee for invalid tenant Id
  * eval updateEmployeeRequest.Employees = Employees 
            Given url hrmsUpdateUrl
              And request updateEmployeeRequest
             When method post
             Then status 403
              And def hrmsResponseHeader = responseHeaders
              And def hrmsResponseBody = response

        @deactivateEmployeeSuccessfully
        Scenario: hrms deactivate successfully
  * eval updateEmployeeRequest.Employees = Employees
  * eval updateEmployeeRequest.Employees[0].deactivationDetails = updateDeactivatemployeeRequest.deactivationDetails
  * eval updateEmployeeRequest.Employees[0].isActive = false
  * eval updateEmployeeRequest.Employees[0].reActivateEmployee = false
            Given url hrmsUpdateUrl
              And request updateEmployeeRequest
             When method post
             Then status 202
              And def hrmsResponseHeader = responseHeaders
              And def hrmsResponseBody = response