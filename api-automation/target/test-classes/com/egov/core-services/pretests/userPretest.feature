Feature: User Search
        Background:
  * configure headers = read('classpath:com/egov/utils/websCommonHeaders.js')
  * def jsUtils = read('classpath:com/egov/utils/jsUtils.js')
  # initializing user payload objects
  * def multipleTenantId = mdmsCityTenant.tenants[1].code + ',' + mdmsCityTenant.tenants[3].code
  * call read('../../core-services/pretests/userCreation.feature@usercreation')
  * def existingUser = createdUser
  * def mobileNumberGen = randomMobileNumGen(10)
  * def unRegisteredNumber = new java.math.BigDecimal(mobileNumberGen)
  * def withoutUserName = ''
  * def emptyStringInTenantId = ''
  * def userConstant = read('../../core-services/constants/user.yaml')
  * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
  * def invalidTenantId = commonConstants.invalidParameters.invalidTenantId
  * def findUser = read('../../core-services/requestPayload/user-creation/searchUser.json')
  
        @findUser
        Scenario: Search user with valid details
     * def payload = findUser.validPayload
            Given url searchUser
     
              And request payload
              * print payload
     
             When method post
             Then status 200
              And def searchUserResponseHeader = responseHeaders
              And def searchUserResponseBody = response

        @findUserWithMultipleTenantid
        Scenario: Search user with multiple tenantIds
     * def payload = findUser.validPayload
     * set findUser.validPayload.tenantId = multipleTenantId
            Given url searchUser
                  * print searchUser
              And request payload
     
             When method post
             Then status 200
              And def searchUserResponseHeader = responseHeaders
              And def searchUserResponseBody = response
  
        @findUserWithInvalidUsername
        Scenario: Search user with invalid username
     * def payload = findUser.validPayload
     * set findUser.validPayload.userName = unRegisteredNumber
            Given url searchUser
     
              And request payload
     
             When method post
             Then status 200
              And def searchUserResponseHeader = responseHeaders
              And def searchUserResponseBody = response

        @findUserWithInvalidTenantid
        Scenario: Search user with invalid tenantId
     * def payLoad = findUser.validPayload  
     * set findUser.validPayload.tenantId = invalidTenantId
            Given url searchUser
     
              And request payLoad
     
             When method post
             Then status 200
              And def searchUserResponseHeader = responseHeaders
              And def searchUserResponseBody = response

        @findUserWithoutUsername
        Scenario: Search user without username
     * def payLoad = findUser.validPayload 
     * set findUser.validPayload.userName = withoutUserName
            Given url searchUser
     
              And request payLoad
     
             When method post
             Then status 400
              And def searchUserResponseHeader = responseHeaders
              And def searchUserResponseBody = response

        @findUserWithoutTenantid
        Scenario: Search user without tenantId
     * def payLoad = findUser.invalidPayload
            Given url searchUser
     
              And request payLoad
     
             When method post
             Then status 400
              And def searchUserResponseHeader = responseHeaders
              And def searchUserResponseBody = response

        @findUserEmptyTenantid
        Scenario: Search user with empty tenantId
     * def payLoad = findUser.validPayload
     * set findUser.validPayload.tenantId = emptyStringInTenantId
            Given url searchUser
     
              And request payLoad
     
             When method post
             Then status 400
              And def searchUserResponseHeader = responseHeaders
              And def searchUserResponseBody = response