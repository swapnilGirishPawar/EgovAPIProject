Feature: collection-services-Create tests

        Background:
    * call read('../../business-services/tests/billingServicesDemand.feature@create_01')
    * def jsUtils = read('classpath:com/egov/utils/jsUtils.js')
    * configure headers = read('classpath:com/egov/utils/websCommonHeaders.js')
    * def collectionServicesConstants = read('../../business-services/constants/collection-services.yaml')
    * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
    * call read('../../business-services/pretest/billingServicePretest.feature@fetchBill')
    * def paidBillIdError = collectionServicesConstants.errorMessages.paidBillId
    * def invalidBillIdError = collectionServicesConstants.errorMessages.invalidBillId
    * def totalAmountPaidError = collectionServicesConstants.errorMessages.totalAmountPaidNull
    * def invalidPaymentModeError = collectionServicesConstants.errorMessages.invalidPaymentMode
    * def invalidTenantIdError = commonConstants.errorMessages.invalidTenantIdError
    * def nullTenantIdError = commonConstants.errorMessages.nullParameterError
    * def reason = collectionServicesConstants.parameters.reason
    * def action = collectionServicesConstants.parameters.action
    * def instrumentDateError = collectionServicesConstants.errorMessages.instrumentDateAsNull
    * def instrumentPastDateError = collectionServicesConstants.errorMessages.instrumentDatePastNinetyDays
    * def instrumentFutureDateError = collectionServicesConstants.errorMessages.futureInstrumentDate
    * def moreThanDueAmountError = collectionServicesConstants.errorMessages.moreThanDueAmount
    * def instrumentNumberError = collectionServicesConstants.errorMessages.instrumentNumberAsEmptyString
    * def transactionNumberError = collectionServicesConstants.errorMessages.transactionNumberAsEmptyString

        @create_PaymentWithValidBillID_01 @businessServices @regression @positive @createPayment @collectionServices
        Scenario: Make payment with valid Bill id
     * call read('../../business-services/pretest/collectionServicesPretest.feature@createPayment')
     * match response.ResponseInfo.status == '200 OK'
     * def paymentId = collectionServicesResponseBody.Payments[0].id
     * call read('../../business-services/pretest/collectionServicesPretest.feature@processworkflow')

        @create_PaymentWithPaidBillID_02 @businessServices @regression @negative @createPayment @collectionServices
        Scenario: Make payment with paid Bill id
     # Make payment with valid Bill id first
     * call read('../../business-services/pretest/collectionServicesPretest.feature@createPayment')
     * def paymentId = collectionServicesResponseBody.Payments[0].id
    # Set the `billId` value with paid bill id
     * set createPaymentRequest.Payment.paymentDetails[0].billId = billId
     * def amount = fetchBillResponse.Bill[0].totalAmount
     * set createPaymentRequest.Payment.paymentDetails[0].totalDue = amount
     * set createPaymentRequest.Payment.paymentDetails[0].totalAmountPaid = amount
     * set createPaymentRequest.Payment.totalDue = amount
     * set createPaymentRequest.Payment.totalAmountPaid = amount
     # Calling steps to Cancel the Payment along with Payment Id
     * call read('../../business-services/pretest/collectionServicesPretest.feature@errorInCreatePayment')
     * match collectionServicesResponseBody.Errors[0].message == paidBillIdError
     * call read('../../business-services/pretest/collectionServicesPretest.feature@processworkflow')

        @create_PaymentWithInvalidBillID_03 @businessServices @regression @negative @createPayment @collectionServices
        Scenario: Make payment with invalid Bill id
    # Make payment with invalid Bill id 
    * call read('../../business-services/pretest/collectionServicesPretest.feature@errorBillId')
    * match response.Errors[0].message == invalidBillIdError
    
        @create_PaymentWithInvalidBusinessService_04 @businessServices @regression @positive @createPayment @collectionServices
        Scenario: Make payment with invalid Business ID
    # Make payment with invalid Bill id 
    * call read('../../business-services/pretest/collectionServicesPretest.feature@errorBusinessService')
    * match response.ResponseInfo.status == '200 OK'
    * def paymentId = collectionServicesResponseBody.Payments[0].id
    # Calling steps to Cancel the Payment along with Payment Id
    * call read('../../business-services/pretest/collectionServicesPretest.feature@processworkflow')

        @create_PaymentWithAmountpaid_Null_05 @businessServices @regression @negative @createPayment @collectionServices
        Scenario: Make payment with invalid Business ID
    # Make payment with invalid Bill id 
    * call read('../../business-services/pretest/collectionServicesPretest.feature@totalAmountPaidNull')
    * match response.Errors[0].message == totalAmountPaidError

        @create_PaymentWith_PaymentModeCard_06 @businessServices @regression @positive @createPayment @collectionServices
        Scenario: Make payment with Card payment mode
    # Make payment with Card type payment mode
    * call read('../../business-services/pretest/collectionServicesPretest.feature@cardPaymentMethod')
    * match response.ResponseInfo.status == '200 OK'

        @create_PaymentWith_InvalidPaymentMode_07 @businessServices @regression @negative @createPayment @collectionServices
        Scenario: Make payment with invalid Payment mode
    # Make payment with invalid Payment Mode
    * call read('../../business-services/pretest/collectionServicesPretest.feature@errorPaymentMode')
    * match response.Errors[0].message == invalidPaymentModeError

        @create_PaymentWith_InvalidtenantID_08 @businessServices @regression @negative @createPayment @collectionServices
        Scenario: Make payment with invalid Tenant Id
    # Make payment with invalid Teanant Id
    * call read('../../business-services/pretest/collectionServicesPretest.feature@errorTenantId')
    * match response.Errors[0].message == invalidTenantIdError

        @create_PaymentWith_NotenantID_09 @businessServices @regression @negative @createPayment @collectionServices
        Scenario: Make payment with null Tenant Id
    # Make payment with invalid Tenant Id
    * call read('../../business-services/pretest/collectionServicesPretest.feature@nullTenantIdPayment')
    * match response.Errors[0].message == nullTenantIdError

        @create_PaymentWith_negativeAmount_10 @businessServices @regression @negative @createPayment @collectionServices
        Scenario: Make payment with negative total amount paid
    # Make payment with negative total amount paid value
    * call read('../../business-services/pretest/collectionServicesPretest.feature@negativeTotalAmount')
    * def billId = fetchBillResponse.Bill[0].id
    * def negativeAmountError = "The amount paid for the paymentDetail with bill number: " + billId
    * match response.Errors[0].message == negativeAmountError

    @create_PaymentWith_PaymentModeCheque_11 @businessServices @regression @positive @createPaymentWithCheque @collectionServices
    Scenario: Test to Create Payment with paymentMode CHEQUE
    # Make a payment with cheque
    * call read('../../business-services/pretest/collectionServicesPretest.feature@chequePaymentMethod')
    * match response.ResponseInfo.status == '200 OK'

@create_PaymentWithNoInstrumentDate_12 @businessServices @regression @negative @createPaymentWithCheque @collectionServices
    Scenario: Test to Create Payment with no instrument date
    # Make a payment with cheeque
    * call read('../../business-services/pretest/collectionServicesPretest.feature@errorForInstrumentDateWihChequePayment')
    * match response.Errors[0].message == instrumentDateError

@create_PaymentWithPast90InstrumentDate_13 @businessServices @regression @negative @createPaymentWithCheque @collectionServices
   Scenario: Test to Create Payment with Past 90 instrument date
   # Make a payment with cheeque
   * call read('../../business-services/pretest/collectionServicesPretest.feature@errorForPastDaysInstrumentDateWihChequePayment')
   * match response.Errors[0].message == instrumentPastDateError

@create_PaymentWithFutureInstrumentDate_14 @businessServices @regression @negative @createPaymentWithCheque @collectionServices
   Scenario: Test to Create Payment with future instrument date
   # Make a payment with cheeque
   * call read('../../business-services/pretest/collectionServicesPretest.feature@errorForFutureInstrumentDateWihChequePayment')
   * match response.Errors[0].message == instrumentFutureDateError

@create_PaymentWithMorethanAmountDue_15 @businessServices @regression @negative @createPaymentWithCheque @collectionServices
   Scenario: Test to Create Payment with more than amount due
   # Make a payment with cheeque
   * call read('../../business-services/pretest/collectionServicesPretest.feature@errorForMorethanDueAmountWihChequePayment')
   * match response.Errors[0].message == moreThanDueAmountError

@create_PaymentWithNoInstrumentNumber_16 @businessServices @regression @negative @createPaymentWithCheque @collectionServices
   Scenario: Test to Create Payment with No Instrument number
   # Make a payment with cheeque
   * call read('../../business-services/pretest/collectionServicesPretest.feature@errorForInstrumentNumberWihChequePayment')
   * match response.Errors[0].message == instrumentNumberError

@create_PaymentWithNoTransactioNumber_17 @businessServices @regression @negative @createPaymentWithCheque @collectionServices
   Scenario: Test to Create Payment with No Transaction number
   # Make a payment with cheeque
   * call read('../../business-services/pretest/collectionServicesPretest.feature@errorForTransactionNumberWihChequePayment')
   * match response.Errors[0].message == transactionNumberError

@createPaymentGeneric @businessServices @regression @positive @createPayment @collectionServices
        Scenario: Make payment with valid Bill id
     * call read('../../business-services/pretest/collectionServicesPretest.feature@createPayment')
     * match response.ResponseInfo.status == '200 OK'
     * def paymentId = collectionServicesResponseBody.Payments[0].id