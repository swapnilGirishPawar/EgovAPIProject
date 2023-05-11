Feature: Localization Messages API call

        Background:
	* def jsUtils = read('classpath:com/egov/utils/jsUtils.js')
  * def upsertRequest = read('../requestPayload/localization/upsert.json')
  * configure headers = read('classpath:com/egov/utils/websCommonHeaders.js')
	
        @upsertLocalizationSuccessfully
        Scenario: Upsert with Success call

            Given url upsertUrl
              And request upsertRequest
             When method post
             Then status 200
              And def upsertResponseHeader = responseHeaders
              And def upsertResponseBody = response


        @upsertLocalizationError
        Scenario: Upsert with Error call
  
            Given url upsertUrl
              And request upsertRequest
             When method post
             Then status 400
              And def upsertResponseHeader = responseHeaders
              And def upsertResponseBody = response


        @upsertLocalizationErrorAccessingResource
        Scenario: Upsert with Error call

            Given url upsertUrl
              And request upsertRequest
             When method post
             Then status 403
              And def upsertResponseHeader = responseHeaders
              And def upsertResponseBody = response