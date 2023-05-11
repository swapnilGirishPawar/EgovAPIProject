Feature: Dashboard Analytics API call 

Background:

  * def jsUtils = read('classpath:com/egov/utils/jsUtils.js')
  	# calling dashboard Json
  * def dashboardRequest = read('../requestPayload/dashboard-analytics/dashboard.json')
  * configure headers = read('classpath:com/egov/utils/websCommonHeaders.js')

@processDashboard
Scenario: success dashboard

  Given url configHomeUrl 
  And header auth-token = authToken
  When method get
  Then status 200
  And def dashboardResponseHeader = responseHeaders
  And def dashboardResponseBody = response

@processDashboardChart
Scenario: success dashboard char API

  Given url getChartUrl 
  And request dashboardRequest
  When method post
  Then status 200
  And def dashboardResponseHeader = responseHeaders
  And def dashboardResponseBody = response

@errorDashboardChart
Scenario: success dashboard

  Given url getChartUrl 
  And request dashboardRequest
  When method post
  Then status 403
  And def dashboardResponseHeader = responseHeaders
  And def dashboardResponseBody = response