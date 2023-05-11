Feature: Property Tax Page Feature

Background:
    * def propertyTaxPage = read('../../ui-services/page-objects/propertyTax.yaml')
    * def pTPageObjects = propertyTaxPage.objects

@makeFullPayment
Scenario: Search property tax by unique id and make full payment
	* waitFor(pTPageObjects.propertyTaxModule).click()
	* waitFor(pTPageObjects.payPropertyTax).click()
	* waitFor(pTPageObjects.selectCity).click()
	* input(pTPageObjects.selectCity, [stateCode, Key.ENTER], 100)
	* input(pTPageObjects.uniquePropertyIdField, propertyId)
	* click(pTPageObjects.searchPropertyButton)
	* def selectPropertyId = pTPageObjects.selectPropertyId
	* replace selectPropertyId.propertyId = propertyId
	* waitFor(selectPropertyId).click()
	* delay(3000)
	* waitFor(pTPageObjects.assessPropertyButton).click()
	* waitFor(pTPageObjects.financialYearRadioButton).click()
	* click(pTPageObjects.financialOkButton)
	* waitFor(pTPageObjects.iAgreeCheckbox).click()
	* waitFor(pTPageObjects.assessPropertyButton).click()
	* waitFor(pTPageObjects.proceedToPaymentButton).click()
	* delay(3000)
	* retry(3, 5000).waitFor(pTPageObjects.makePaymentButton).click()
	* call read('../../ui-services/pages/paymentGatewayPage.feature@makePayment')
	* retry(6, 5000).waitFor(pTPageObjects.paymentReceiptNumber)
	* def paymentReceiptNumber = text(pTPageObjects.paymentReceiptNumber)
	# * print paymentReceiptNumber

@makePartialPayment
Scenario: Search property tax by unique id and make partial payment
	* waitFor(pTPageObjects.propertyTaxModule).click()
	* waitFor(pTPageObjects.payPropertyTax).click()
	* waitFor(pTPageObjects.selectCity).click()
	* input(pTPageObjects.selectCity, [stateCode, Key.ENTER], 100)
	* input(pTPageObjects.uniquePropertyIdField, propertyId)
	* click(pTPageObjects.searchPropertyButton)
	* def selectPropertyId = pTPageObjects.selectPropertyId
	* replace selectPropertyId.propertyId = propertyId
	* waitFor(selectPropertyId).click()
	* delay(3000)
	* waitFor(pTPageObjects.assessPropertyButton).click()
	* waitFor(pTPageObjects.financialYearRadioButton).click()
	* click(pTPageObjects.financialOkButton)
	* waitFor(pTPageObjects.iAgreeCheckbox).click()
	* waitFor(pTPageObjects.assessPropertyButton).click()
	* waitFor(pTPageObjects.proceedToPaymentButton).click()
	* delay(3000)
	* waitFor(pTPageObjects.partialAmountRadioButton).click()
	* waitFor(pTPageObjects.amountToPayField)
	* input(pTPageObjects.amountToPayField, [Key.BACK_SPACE, Key.BACK_SPACE, Key.BACK_SPACE, Key.BACK_SPACE, Key.BACK_SPACE, Key.BACK_SPACE, Key.BACK_SPACE, Key.BACK_SPACE, amountToPay], 100)
	* retry(3, 5000).waitFor(pTPageObjects.makePaymentButton).click()
	* call read('../../ui-services/pages/paymentGatewayPage.feature@makePayment')
	* retry(6, 5000).waitFor(pTPageObjects.paymentReceiptNumber)
	* def paymentReceiptNumber = text(pTPageObjects.paymentReceiptNumber)
	# * print paymentReceiptNumber

@makeMutationPayment
Scenario: Search property tax by unique id and make full payment
	* waitFor(pTPageObjects.propertyTaxModule).click()
	* waitFor(pTPageObjects.payPropertyTax).click()
	* waitFor(pTPageObjects.searchApplication).click()
	* waitFor(pTPageObjects.applicationNumberField).input(acknowldgementNumber)
	* click(pTPageObjects.searchPropertyButton)
	* def selectApplicationNumber = pTPageObjects.selectApplicationNumber
	* replace selectApplicationNumber.acknowldgementNumber = acknowldgementNumber
	* waitFor(selectApplicationNumber).click()
	* waitFor(pTPageObjects.takeActionButton).click()
	* waitFor(pTPageObjects.citizenPayActionButton).click()
	* delay(3000)
	* retry(3, 5000).waitFor(pTPageObjects.makePaymentButton).click()
	* call read('../../ui-services/pages/paymentGatewayPage.feature@makePayment')
	* retry(6, 5000).waitFor(pTPageObjects.paymentReceiptNumber)
	* def paymentReceiptNumber = text(pTPageObjects.paymentReceiptNumber)
	# * print paymentReceiptNumber