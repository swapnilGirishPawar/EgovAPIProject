Feature: Pretest scenarios of egf-master account details types service end points
Background:
      * def jsUtils = read('classpath:com/egov/utils/jsUtils.js')
      * configure headers = read('classpath:com/egov/utils/websCommonHeaders.js')
      * def egfMasterConstants = read('../../business-services/constants/egfMaster.yaml') 
      * def accountDetailTypesCreatePayload = read('../../business-services/requestPayload/egf-master/accountDetailTypes/create.json')
      * def accountDetailTypesUpdatePayload = read('../../business-services/requestPayload/egf-master/accountDetailTypes/update.json')
      * def accountDetailTypesSearchPayload = read('../../business-services/requestPayload/egf-master/accountDetailTypes/search.json')
  
      @createAccountSuccessfully
      Scenario: Creating Unique account detail type through API call
      * def accountCreateParam = 
      """
      {
      tenantId: '#(tenantId)'
      }
      """ 
      Given url accountDetailTypesCreate
      And params accountCreateParam
      And request accountDetailTypesCreatePayload
      When method post
      Then status 201
      And def accountDetailTypesCreateResponseHeader = responseHeaders
      And def accountDetailTypesCreateResponseBody = response

      @negativeTestCase
      Scenario: Negative case Creating Unique account detail type through API call
      * def accountCreateParam = 
      """
      {
      tenantId: '#(tenantId)'
      }
      """ 
      Given url accountDetailTypesCreate 
      And params accountCreateParam
      And request accountDetailTypesCreatePayload
      When method post
      Then status 400
      And def accountDetailTypesCreateResponseHeader = responseHeaders
      And def accountDetailTypesCreateResponseBody = response

      @updateAccountSuccessfully
      Scenario: Update Unique account detail type through API call
      * def accountUpdateParam = 
      """
      {
      tenantId: '#(tenantId)'
      }
      """ 
      Given url accountDetailTypesUpdate
      And params accountUpdateParam
      And request accountDetailTypesUpdatePayload
      When method post
      Then status 201
      And def accountDetailTypesUpdateResponseHeader = responseHeaders
      And def accountDetailTypesUpdateResponseBody = response

      @negativeUpdate
      Scenario: Update Unique account detail type through API call
      * def accountUpdateParam = 
      """
      {
      tenantId: '#(tenantId)'
      }
      """ 
      Given url accountDetailTypesUpdate
      And params accountUpdateParam
      And request accountDetailTypesUpdatePayload
      When method post
      Then status 400
      And def accountDetailTypesUpdateResponseHeader = responseHeaders
      And def accountDetailTypesUpdateResponseBody = response

      @invalidTenantIdUpdate
      Scenario: Invalid TenantID
      * def accountUpdateParam = 
      """
      {
      tenantId: '#(tenantId)'
      }
      """ 
      Given url accountDetailTypesUpdate
      And params accountUpdateParam
      And request accountDetailTypesUpdatePayload
      When method post
      Then status 403
      And def accountDetailTypesUpdateResponseHeader = responseHeaders
      And def accountDetailTypesUpdateResponseBody = response

      @searchAccount
      Scenario: Search Unique account detail type through API call
      * def accountSearchParam = 
      """
      {
      tenantId: '#(tenantId)'
      }
      """ 
      Given url accountDetailTypesSearch
      And params accountSearchParam
      And request accountDetailTypesSearchPayload
      When method post
      Then status 200
      And def accountDetailTypesSearchResponseHeader = responseHeaders
      And def accountDetailTypesSearchResponseBody = response

      @negativeSearchUnAuthorized
      Scenario: Search Unique account detail type through API call
      * def accountSearchParam = 
      """
      {
      tenantId: '#(tenantId)'
      }
      """ 
      Given url accountDetailTypesSearch
      And params accountSearchParam
      And request accountDetailTypesSearchPayload
      When method post
      Then status 403
      And def accountDetailTypesSearchResponseHeader = responseHeaders
      And def accountDetailTypesSearchResponseBody = response