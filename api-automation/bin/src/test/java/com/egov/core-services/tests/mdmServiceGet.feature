Feature: Mdm Service Get tests

Background:
    *  def jsUtils = read('classpath:com/egov/utils/jsUtils.js')
    *  def mdmsServiceConstants = read('../../core-services/constants/mdmsServiceGet.yaml')
    *  def moduleName = mdmsServiceConstants.parameters.moduleName
    *  def masterName = mdmsServiceConstants.parameters.masterName
    *  def mdmsParam = {moduleName: '#(moduleName.split(",")[0])',tenantId: '#(tenantId)',masterName: '#(masterName)'}
    *  def serviceCode = mdmsServiceConstants.expectedResponse.serviceCode
    *  def keywords = mdmsServiceConstants.expectedResponse.keywords
    *  def department = mdmsServiceConstants.expectedResponse.department
    *  def slaHours = mdmsServiceConstants.expectedResponse.slaHours
    *  def menuPath = mdmsServiceConstants.expectedResponse.menuPath
    *  def active = mdmsServiceConstants.expectedResponse.active
    *  def order = mdmsServiceConstants.expectedResponse.order

@Get_MDMS_01 @coreServices @regression @positive @getMdms @mdmsService
Scenario: Test to get MDMS details
    # calling mdms get pretest
    * call read('../../core-services/pretests/mdmsService.feature@getMdmsSuccessfully')
    * def mdmsResponseArray = getMdmsResponseBody.MdmsRes['RAINMAKER-PGR'].ServiceDefs
    # verifying response body parameters
    * assert mdmsResponseArray.size() > 0
    * match  mdmsResponseArray[*].serviceCode contains ['#(serviceCode)']
    * match  mdmsResponseArray[*].keywords contains ['#(keywords)']
    * match  mdmsResponseArray[*].department contains ['#(department)']
    * match  mdmsResponseArray[*].slaHours contains ['#(slaHours)']
    * match  mdmsResponseArray[*].menuPath contains ['#(menuPath)']
    * match  mdmsResponseArray[*].active contains ['#(active)']
    * match  mdmsResponseArray[*].order contains ['#(order)']

@Get_MDMS_MultipleMod_02 @coreServices @regression @negative @getMdms @mdmsService
Scenario: Test to get MDMS details with multiple module name
    * set mdmsParam.moduleName = moduleName
    # calling mdms get pretest
    * call read('../../core-services/pretests/mdmsService.feature@getMdmsSuccessfully')
    * match getMdmsResponseBody.MdmsRes == {}

@Get_MDMS_NoModName_03 @coreServices @regression @negative @getMdms @mdmsService
Scenario: Test to get MDMS details with no module name
    * def mdmsParam = {tenantId: '#(tenantId)',masterName: '#(masterName)'}
    # calling mdms get pretest
    * call read('../../core-services/pretests/mdmsService.feature@ErrorInGetMdms')
    * match getMdmsResponseBody.Errors[0].message == mdmsServiceConstants.errorMessages.noModuleName.message
    * match getMdmsResponseBody.Errors[0].params[0] == mdmsServiceConstants.errorMessages.noModuleName.params

@Get_MDMS_NoMasterName_04 @coreServices @regression @negative @getMdms @mdmsService
Scenario: Test to get MDMS details with no module name
    * def mdmsParam = {moduleName: '#(moduleName.split(",")[0])',tenantId: '#(tenantId)'}
    # calling mdms get pretest
    * call read('../../core-services/pretests/mdmsService.feature@ErrorInGetMdms')
    * match getMdmsResponseBody.Errors[0].message == mdmsServiceConstants.errorMessages.noMasterName.message
    * match getMdmsResponseBody.Errors[0].params[0] == mdmsServiceConstants.errorMessages.noMasterName.params

@Get_MDMS_NoTenantId_05 @coreServices @regression @negative @getMdms @mdmsService
Scenario: Test to get MDMS details with no tenant Id
    * set mdmsParam.tenantId = null
    # calling mdms get pretest
    * call read('../../core-services/pretests/mdmsService.feature@ErrorInGetMdms')
    * match getMdmsResponseBody.Errors[0].message == mdmsServiceConstants.errorMessages.noTenantId.message
    * match getMdmsResponseBody.Errors[0].params[0] == mdmsServiceConstants.errorMessages.noTenantId.params

@Get_MDMS_InvalidTenantId_06 @coreServices @regression @negative @getMdms @mdmsService
Scenario: Test to get MDMS details with invalid tenant ID
    * set mdmsParam.tenantId = 'invalid_'+ ranString(5)
    # calling mdms get pretest
    * call read('../../core-services/pretests/mdmsService.feature@ErrorInGetMdms')
    # Validating two different error messages as its vary based on environments
    * assert getMdmsResponseBody.Errors[0].message == mdmsServiceConstants.errorMessages.invalidTenantId.message || getMdmsResponseBody.Errors[0].message == mdmsServiceConstants.errorMessages.invalidTenantId.messageQa
    * assert getMdmsResponseBody.Errors[0].code == mdmsServiceConstants.errorMessages.invalidTenantId.code || getMdmsResponseBody.Errors[0].code == mdmsServiceConstants.errorMessages.invalidTenantId.codeQa

@Get_MDMS_Invalidparamvalues_07 @coreServices @regression @negative @getMdms @mdmsService
Scenario: Test to get MDMS details with invalid module name and service name
    * set mdmsParam.moduleName = 'invalid_'+ ranString(5)
    * set mdmsParam.masterName = 'invalid_'+ ranString(5)
    # calling mdms get pretest
    * call read('../../core-services/pretests/mdmsService.feature@ErrorInGetMdms')
    * match getMdmsResponseBody.MdmsRes == {}