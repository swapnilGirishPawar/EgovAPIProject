Feature: FSM-Service pretests
    Background:
        * def jsUtils = read('classpath:com/egov/utils/jsUtils.js')
        * def createFsmRequest = read('../../municipal-services/requestPayload/fsm-service/create.json')
        * def createSantiFsmRequest = read('../../municipal-services/requestPayload/fsm-service/create_Santi.json')
        * def searchFsmRequest = read('../../municipal-services/requestPayload/fsm-service/search.json')
        * def updateFsmRequest = read('../../municipal-services/requestPayload/fsm-service/update.json')
        * def auditFsmRequest = read('../../municipal-services/requestPayload/fsm-service/audit.json')
        * def vendorCreateFsmRequest = read('../../municipal-services/requestPayload/fsm-service/vendorCreate.json')
        * def vendorSearchFsmRequest = read('../../municipal-services/requestPayload/fsm-service/vendorSearch.json')
        * def vehicalCreateFsmRequest = read('../../municipal-services/requestPayload/fsm-service/vehicalCreate.json')
        * def vehicalSearchFsmRequest = read('../../municipal-services/requestPayload/fsm-service/vehicalSearch.json')
        * def vehicalTripSearchFsmRequest = read('../../municipal-services/requestPayload/fsm-service/vehicalTripSearch.json')
        * def vehicalTripCreateFsmRequest = read('../../municipal-services/requestPayload/fsm-service/vehicalTripCreate.json')
        * def vehicalTripUpdateFsmRequest = read('../../municipal-services/requestPayload/fsm-service/vehicalTripUpdate.json')
        * def createNoSlumFsmRequest = read('../../municipal-services/requestPayload/fsm-service/createNoSlum.json')
        * def createPaymentRequest = read('../../municipal-services/requestPayload/fsm-service/payment.json')

    @createFsmSuccessfully
    Scenario: Create FSM successfully
        Given url createFsmEvent
        And request createFsmRequest
        When method post
        Then status 200
        And def fsmResponseBody = response
        And def fsmBody = fsmResponseBody.fsm[0]
        And def fsmId = fsmResponseBody.fsm[0].id
        And def applicationNo = fsmResponseBody.fsm[0].applicationNo
        And def applicationStatus = fsmResponseBody.fsm[0].applicationStatus
        And def fsmStatus = fsmResponseBody.fsm[0].status
        And def tenantId = fsmResponseBody.fsm[0].tenantId

    @createFsmError
    Scenario: Create FSM Error
        Given url createFsmEvent
        And request createSantiFsmRequest
        When method post
        Then status 400
        And def fsmResponseBody = response

    @createPaymentFsmSuccessfully
    Scenario: create Payment successfully
        Given url paymentsCreateFsmEvent
        And request createPaymentRequest
        When method post
        Then status 200
        And def fsmResponseBody = response

    @fetchBillSuccessfully
    Scenario: fetch Bill successfully
        Given url fetchBill
        And params getFsmSearchParam
        And request searchFsmRequest
        When method post
        Then status 201
        And def fsmResponseBody = response
        And def billId = fsmResponseBody.Bill[0].id
        And def payerName = fsmResponseBody.Bill[0].payerName
        And def businessService = fsmResponseBody.Bill[0].businessService
        And def billDate = fsmResponseBody.Bill[0].billDate

    @updateFsmSuccessfully
    Scenario: update FSM successfully
        Given url updateFsmEvent
        And request updateFsmRequest
        # * print updateFsmRequest
        When method post
        Then status 200
        And def fsmResponseBody = response

    @updateFsmError
    Scenario: update FSM Error
        Given url updateFsmEvent
        And request updateFsmRequest
        When method post
        Then status 400
        And def fsmResponseBody = response

    @SearchFsmSuccessfully
    Scenario: search FSM successfully
        Given url searchFsmEvent
        And params getFsmSearchParam
        And request searchFsmRequest
        When method post
        Then status 200
        And def fsmResponseBody = response

    @searchFsmError
    Scenario: search FSM Error
        Given url searchFsmEvent
        And params getFsmSearchParam
        And request searchFsmRequest
        When method post
        Then status 403
        And def fsmResponseBody = response

    @searchFsmError1
    Scenario: search FSM Error
        Given url searchFsmEvent
        And params getFsmSearchParam
        And request searchFsmRequest
        When method post
        Then status 400
        And def fsmResponseBody = response

    @auditFsmSuccessfully
    Scenario: Audit FSM successfully
        Given url auditFsmEvent
        And params getFsmAuditParam
        And request auditFsmRequest
        When method post
        Then status 200
        And def fsmResponseBody = response

    @auditFsmError
    Scenario: Audit FSM Error
        Given url auditFsmEvent
        And params getFsmAuditParam
        And request auditFsmRequest
        When method post
        Then status 400
        And def fsmResponseBody = response

    @auditFsmError1
    Scenario: Audit FSM Error
        Given url auditFsmEvent
        And params getFsmAuditParam
        And request auditFsmRequest
        When method post
        Then status 403
        And def fsmResponseBody = response

    @vendorCreateFsmSuccessfully
    Scenario: Vendor Create FSM successfully
        Given url vendorCreateFsmEvent
        And request vendorCreateFsmRequest
        When method post
        Then status 200
        And def fsmResponseBody = response

    @vendorCreateFsmError
    Scenario: Vendor Create FSM error
        Given url vendorCreateFsmEvent
        And request vendorCreateFsmRequest
        When method post
        Then status 400
        And def fsmResponseBody = response

    @vendorSearchFsmSuccessfully
    Scenario: Vendor Search FSM successfully
        Given url vendorSearchFsmEvent
        And params getFsmVendorSearchParam
        And request vendorSearchFsmRequest
        When method post
        Then status 200
        And def fsmResponseBody = response
        And def state = fsmResponseBody.vendor[0].address.state
        And def country = fsmResponseBody.vendor[0].address.country
        And def pincode = fsmResponseBody.vendor[0].address.pincode

    @vendorSearchFsmError
    Scenario: Vendor Search FSM Error
        Given url vendorSearchFsmEvent
        And params getFsmVendorSearchParam
        And request vendorSearchFsmRequest
        When method post
        Then status 400
        And def fsmResponseBody = response

    @vehicalCreateFsmSuccessfully
    Scenario: Vehical Create FSM successfully
        Given url vehicalCreateFsmEvent
        And request vehicalCreateFsmRequest
        When method post
        Then status 200
        And def fsmResponseBody = response

    @vehicalCreateFsmError
    Scenario: Vehical Create FSM Error
        Given url vehicalCreateFsmEvent
        And request vehicalCreateFsmRequest
        When method post
        Then status 400
        And def fsmResponseBody = response

    @vehicalCreateFsmError1
    Scenario: Vehical Create FSM Error
        Given url vehicalCreateFsmEvent
        And request vehicalCreateFsmRequest
        When method post
        Then status 403
        And def fsmResponseBody = response

    @vehicalCreateFsmError2
    Scenario: Vehical Create FSM Error without Registation Number
        * eval karate.remove('vehicalCreateFsmRequest', removeFieldPath)
        Given url vehicalCreateFsmEvent
        And request vehicalCreateFsmRequest
        When method post
        Then status 400
        And def fsmResponseBody = response
    
    @vehicalSearchFsmSuccessfully
    Scenario: Vehical Search FSM successfully
        Given url vehicalSearchFsmEvent
        And params getFsmVehicalSearchParam
        And request vehicalSearchFsmRequest
        When method post
        Then status 200
        And def fsmResponseBody = response
        And def vehicalId = fsmResponseBody.vehicle[0].id
        And def registrationNumber = fsmResponseBody.vehicle[0].registrationNumber
        And def model = fsmResponseBody.vehicle[0].model
        And def type = fsmResponseBody.vehicle[0].type
        And def tankCapacity = fsmResponseBody.vehicle[0].tankCapacity
        And def suctionType = fsmResponseBody.vehicle[0].suctionType
        And def pollutionCertiValidTill = fsmResponseBody.vehicle[0].pollutionCertiValidTill
        And def source = fsmResponseBody.vehicle[0].source
        And def ownerId = fsmResponseBody.vehicle[0].ownerId
        And def status = fsmResponseBody.vehicle[0].status
        And def ownerid = fsmResponseBody.vehicle[0].owner.id
        And def userName = fsmResponseBody.vehicle[0].owner.userName
        And def ownerName = fsmResponseBody.vehicle[0].owner.name
        And def gender = fsmResponseBody.vehicle[0].owner.gender
        And def fatherOrHusbandName = fsmResponseBody.vehicle[0].owner.fatherOrHusbandName
        And def relationship = fsmResponseBody.vehicle[0].owner.relationship
        And def correspondenceAddress = fsmResponseBody.vehicle[0].owner.correspondenceAddress
        And def dob = fsmResponseBody.vehicle[0].owner.dob
        And def pwdExpiryDate = fsmResponseBody.vehicle[0].owner.pwdExpiryDate
        And def ownerType = fsmResponseBody.vehicle[0].owner.type
        And def emailId = fsmResponseBody.vehicle[0].owner.emailId
        And def mobileNumber = fsmResponseBody.vehicle[0].owner.mobileNumber
        And def ownerRoleName = fsmResponseBody.vehicle[0].owner.roles[0].name
        And def ownerRoleCode = fsmResponseBody.vehicle[0].owner.roles[0].code
        And def ownerRoleTenantId = fsmResponseBody.vehicle[0].owner.roles[0].tenantId

    @vehicalSearchFsmError
    Scenario: Vehical Search FSM Error
        Given url vehicalSearchFsmEvent
        And params getFsmVehicalSearchParam
        And request vehicalSearchFsmRequest
        When method post
        Then status 400
        And def fsmResponseBody = response

    @vehicalSearchFsmError1
    Scenario: Vehical Search FSM Error
        Given url vehicalSearchFsmEvent
        And params getFsmVehicalSearchParam
        And request vehicalSearchFsmRequest
        When method post
        Then status 403
        And def fsmResponseBody = response

    @vehicalTripSearchFsmSuccessfully
    Scenario: Vehical Trip Search FSM successfully
        Given url vehicalTripSearchFsmEvent
        And params getFsmTripSearchParam
        And request vehicalTripSearchFsmRequest
        When method post
        Then status 200
        And def fsmResponseBody = response

    @vehicalTripSearchFsmError1
    Scenario: Vehical Trip Search FSM Error
        Given url vehicalTripSearchFsmEvent
        And params getFsmTripSearchParam
        And request vehicalTripSearchFsmRequest
        When method post
        Then status 400
        And def fsmResponseBody = response

    @vehicalTripSearchFsmError
    Scenario: Vehical Trip Search FSM Error
        Given url vehicalTripSearchFsmEvent
        And params getFsmTripSearchParam
        And request vehicalTripSearchFsmRequest
        When method post
        Then status 403
        And def fsmResponseBody = response

    @vehicalTripCreateFsmSuccessfully
    Scenario: Vehical Trip Create FSM successfully
        Given url vehicalTripCreateFsmEvent
        And request vehicalTripCreateFsmRequest
        When method post
        Then status 200
        And def fsmResponseBody = response
        And def vehicakBody = fsmResponseBody.vehicleTrip[0]

    @vehicalTripCreateFsmError
    Scenario: Vehical Trip Create FSM Error
        Given url vehicalTripCreateFsmEvent
        And request vehicalTripCreateFsmRequest
        When method post
        Then status 400
        And def fsmResponseBody = response

    @vehicalTripCreateFsmError1
    Scenario: Vehical Trip Create FSM Error
        Given url vehicalTripCreateFsmEvent
        And request vehicalTripCreateFsmRequest
        When method post
        Then status 403
        And def fsmResponseBody = response

    @vehicalTripCreateFsmError2
    Scenario: Vehical Trip Create FSM Error without vehical ID
        * eval karate.remove('vehicalTripCreateFsmRequest', removeFieldPath)
        Given url vehicalTripCreateFsmEvent
        And request vehicalTripCreateFsmRequest
        When method post
        Then status 400
        And def fsmResponseBody = response

    @vehicalTripUpdateFsmSuccessfully
    Scenario: Vehical Trip Update FSM successfully
        Given url vehicalTripUpdateFsmEvent
        And request vehicalTripUpdateFsmRequest
        When method post
        Then status 200
        And def fsmResponseBody = response

    @vehicalTripUpdateFsmError
    Scenario: Vehical Trip Update FSM Error
        Given url vehicalTripUpdateFsmEvent
        And request vehicalTripUpdateFsmRequest
        When method post
        Then status 400
        And def fsmResponseBody = response

    @vehicalTripUpdateFsmError1
    Scenario: Vehical Trip Update FSM Error
        Given url vehicalTripUpdateFsmEvent
        And request vehicalTripUpdateFsmRequest
        When method post
        Then status 403
        And def fsmResponseBody = response

    @locationSearchFsmSuccessfully
    Scenario: location search FSM successfully
        Given url searchloc
        And params getFsmSearchParam
        And request searchFsmRequest
        When method post
        Then status 200
        And def fsmResponseBody = response

    @createFsmNoSlumSuccessfully
    Scenario: Create FSM successfully
        Given url createFsmEvent
        And params getFsmSearchParam
        And request createNoSlumFsmRequest
        # * print createNoSlumFsmRequest
        When method post
        Then status 200
        And def fsmResponseBody = response

    @inboxSearchFsmSuccessfully
    Scenario: inbox search FSM successfully
        Given url inboxSearchFsmEvent
        And request searchFsmRequest
        When method post
        Then status 200
        And def fsmResponseBody = response