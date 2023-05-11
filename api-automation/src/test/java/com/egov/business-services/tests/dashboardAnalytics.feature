Feature: Business Services - Dashboard Analytics service tests

        Background:
     * def jsUtils = read('classpath:com/egov/utils/jsUtils.js')
     * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
     * def dashboardServiceData = read('../../business-services/constants/dashboardAnalytics.yaml')
     * def dashboardTestData = read('../../business-services/requestPayload/dashboard-analytics/chartAPI.json')
     * def departmentId = commonConstants.invalidParameters.nullValue
     * def visualizationType = dashboardServiceData.parameters.visualizationType
     * def visualizationCode = dashboardServiceData.parameters.visualizationCode.totalComplaints
     * def startDate = getCurrentEpochTime()
     * def endDate = getCurrentEpochTime()
     * def interval = dashboardServiceData.parameters.interval
     * call read('../../common-services/pretests/egovMdmsPretest.feature@successSearchState')
     * def dashboardConfig = mdmsStateDashboardConfig[0].MODULE_LEVEL
     * def modulePT = dashboardConfig[1].propertytax.filterKey
     * def moduleLevel = dashboardConfig[3].pgr.filterKey
     
     
        @getDashboardConfig_01 @businessServices @regression @positive @dashboardAnalytics
        Scenario: Verify the API call to get config for the dashboard
     # Steps to hit Dashboard API and get Configuration for Dashboard
     * call read('../../business-services/pretest/dashboardAnalyticsPretest.feature@processDashboard')
     * match dashboardResponseBody.statusInfo.statusMessage == dashboardServiceData.expected.successMessages.status
     * assert dashboardResponseBody.responseData[0].visualizations.length != 0 

        @getChartV2_metric_01 @businessServices @regression @positive @dashboardAnalytics
        Scenario: Verify the API call for display of data in metric format
     # Steps to process dashboard chart
     * call read('../../business-services/pretest/dashboardAnalyticsPretest.feature@processDashboardChart')
     * match dashboardResponseBody.statusInfo.statusMessage == dashboardServiceData.expected.successMessages.status
     * match dashboardResponseBody.responseData.visualizationCode == visualizationCode
     * match dashboardResponseBody.responseData.chartType == dashboardServiceData.expected.chartType.metric

        @getChartV2_piechart_02 @businessServices @regression @positive @dashboardAnalytics
        Scenario: Verify the API call for display of data a pie chart
     # Defining visualizationCode with complaintsByStatus parameter value 
     * def visualizationCode = dashboardServiceData.parameters.visualizationCode.complaintsByStatus
     * call read('../../business-services/pretest/dashboardAnalyticsPretest.feature@processDashboardChart')
     * match dashboardResponseBody.statusInfo.statusMessage == dashboardServiceData.expected.successMessages.status
     * match dashboardResponseBody.responseData.visualizationCode == visualizationCode
     * match dashboardResponseBody.responseData.chartType == dashboardServiceData.expected.chartType.pie

        @getChartV2_bargraph_03 @businessServices @regression @positive @dashboardAnalytics
        Scenario: Verify the API call for display of data as bar graph
     # Defining visualizationCode with totalComplaintsbyStatus parameter value
     * def visualizationCode = dashboardServiceData.parameters.visualizationCode.totalComplaintsbyStatus
     * call read('../../business-services/pretest/dashboardAnalyticsPretest.feature@processDashboardChart')
     * match dashboardResponseBody.statusInfo.statusMessage == dashboardServiceData.expected.successMessages.status
     * match dashboardResponseBody.responseData.visualizationCode == visualizationCode
     * match dashboardResponseBody.responseData.chartType == dashboardServiceData.expected.chartType.line

        @getChartV2_multiplelinegraph_04 @businessServices @regression @positive @dashboardAnalytics
        Scenario: Verify the API call for display of data as multiple line graph
     # Defining visualizationCode with totalComplaintsbySource parameter value
     * def visualizationCode = dashboardServiceData.parameters.visualizationCode.totalComplaintsbySource
     * call read('../../business-services/pretest/dashboardAnalyticsPretest.feature@processDashboardChart')
     * match dashboardResponseBody.statusInfo.statusMessage == dashboardServiceData.expected.successMessages.status
     * match dashboardResponseBody.responseData.visualizationCode == visualizationCode
     * match dashboardResponseBody.responseData.chartType == dashboardServiceData.expected.chartType.line

        @getChartV2_filter_05 @businessServices @regression @positive @dashboardAnalytics
        Scenario: Verify the API call for display of data as filter
     # Defining departmentId with xpgrStatusByCatagory parameter value
     * def departmentId = dashboardServiceData.parameters.departmentId
     * def visualizationCode = dashboardServiceData.parameters.visualizationCode.xpgrStatusByCatagory
     * call read('../../business-services/pretest/dashboardAnalyticsPretest.feature@processDashboardChart')
     * match dashboardResponseBody.statusInfo.statusMessage == dashboardServiceData.expected.successMessages.status
     * match dashboardResponseBody.responseData.visualizationCode == visualizationCode
     * match dashboardResponseBody.responseData.chartType == dashboardServiceData.expected.chartType.xtable
     * assert dashboardResponseBody.responseData.filter.length != 0 

        @getChartV2_timeseries_06 @businessServices @regression @positive @dashboardAnalytics
        Scenario: Verify the API call for display of data as timeseries
     # Defining visualizationCode with eventDurationGraph parameter value
     * def visualizationCode = dashboardServiceData.parameters.visualizationCode.eventDurationGraph
     * call read('../../business-services/pretest/dashboardAnalyticsPretest.feature@processDashboardChart')
     * match dashboardResponseBody.statusInfo.statusMessage == dashboardServiceData.expected.successMessages.status
     * match dashboardResponseBody.responseData.visualizationCode == visualizationCode
     * match dashboardResponseBody.responseData.chartType == dashboardServiceData.expected.chartType.line

        @getChartV2_table_07 @businessServices @regression @positive @dashboardAnalytics
        Scenario: Verify the API call for display of data as a table
     # Defining visualizationCode with demandCollectionIndexUsageRevenue parameter value
     * def visualizationCode = dashboardServiceData.parameters.visualizationCode.demandCollectionIndexUsageRevenue
     * call read('../../business-services/pretest/dashboardAnalyticsPretest.feature@processDashboardChart')
     * match dashboardResponseBody.statusInfo.statusMessage == dashboardServiceData.expected.successMessages.status
     * match dashboardResponseBody.responseData.visualizationCode == visualizationCode
     * match dashboardResponseBody.responseData.chartType == dashboardServiceData.expected.chartType.table

        @getChartV2_drill_08 @businessServices @regression @positive @dashboardAnalytics
        Scenario: Verify the API call for display of data as drill through column
     # Defining visualizationCode with wardDrillDown parameter value
     * def visualizationCode = dashboardServiceData.parameters.visualizationCode.wardDrillDown
     # Defining moduleLevel with modulePT
     * def moduleLevel = modulePT
     * call read('../../business-services/pretest/dashboardAnalyticsPretest.feature@processDashboardChart')
     * match dashboardResponseBody.statusInfo.statusMessage == dashboardServiceData.expected.successMessages.status
     * match dashboardResponseBody.responseData.visualizationCode == visualizationCode
     * match dashboardResponseBody.responseData.chartType == dashboardServiceData.expected.chartType.table

        @getChartV2_invalidtenant_09 @businessServices @regression @negative @dashboardAnalytics
        Scenario: Verify the API call for display of dasboard with invalid tenant id
     # Defining tenantId with Invalid tenantId
     * def tenantId = commonConstants.invalidParameters.invalidTenantId
     * call read('../../business-services/pretest/dashboardAnalyticsPretest.feature@errorDashboardChart')
     * match dashboardResponseBody.Errors[0].message == commonConstants.errorMessages.invalidTenantIdError