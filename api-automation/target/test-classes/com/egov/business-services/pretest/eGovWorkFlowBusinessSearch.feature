Feature: eGovWorkFlowBusiness Feature

    Background:
    * def jsUtils = read('classpath:com/egov/utils/jsUtils.js')
    * def workFlowConstants = read('../../business-services/constants/eGovWorkFlowBusiness.yaml')
    * def businessServices = workFlowConstants.inputData.businessServices
    * def searchWorkFlowRequest = read('../../business-services/requestPayload/egov-workflow/business/workFlowSearch.json')
    
@SuccessSearchWorkFlow
Scenario: Search Work Flow
* configure headers = read('classpath:com/egov/utils/websCommonHeaders.js')
    * def parameters =
      """
      {
      tenantId: '#(tenantId)',
      businessServices: '#(businessServices)'
      }
      """
            Given url businessSearch
              And params parameters
              And request searchWorkFlowRequest
              When method post
              Then status 200
              And def searchWorkFlowResponseHeader = responseHeaders
              And def searchWorkFlowResponseBody = response
              And def businessService = searchWorkFlowResponseBody.BusinessServices[0].businessService
              And def states = searchWorkFlowResponseBody.BusinessServices[0].states
              