Feature: eGov_User - Update password no login tests

Background:
     * def jsUtils = read('classpath:com/egov/utils/jsUtils.js')
     * call read('../../common-services/pretests/authenticationToken.feature@authTokenCounterEmployee')
     * def otpReference = randomNumber(5)
     * def newPassword = authPassword
     * def userName = authUsername
     * def type = authUserType
     * def errorMessage = read('../../core-services/constants/user.yaml')
     * def genericError = read("../../common-services/constants/genericConstants.yaml")
     * def updateUserPasswordNoLogin = read('../../core-services/requestPayload/user/updatePasswordNoLogin/updatePasswordNoLogin.json')

@Update_NoLogin_Password_InValidOTP_02 @coreServices @regression @negative @userPasswordNoLogin @eGovUser
Scenario: To validate error message for invalid OTP
        # Steps to update user's password without logged in
        * call read('../../core-services/pretests/eGovUserUpdatePretest.feature@errorInUpdatePasswordNoLogin')
        # Validate actual error message returned by API for unsuccessful OTP validation
        * match updatedPasswordWithOutLogin.error.fields[0].message == errorMessage.errormessages.invalidOTP
                * print errorMessage.errormessages.invalidOTP

@Update_NoLogin_Password_NoOtpReference_03 @coreServices @regression @negative @userPasswordNoLogin @eGovUser
Scenario: To validate error message when otpSignal is missing
        # Remove otpReference field from request
        * remove updateUserPasswordNoLogin.otpReference
        # Steps to update user's password without logged in without otpReference field
        * call read('../../core-services/pretests/eGovUserUpdatePretest.feature@errorInUpdatePasswordNoLogin')
        # Validate actual error retured by API should equal to expected error message
        * match updatedPasswordWithOutLogin['error'].message == errorMessage.errormessages.invalidOTP

@Update_NoLogin_Password_NoNewPassword_04 @coreServices @regression @negative @userPasswordNoLogin @eGovUser
Scenario: To validate error message when newPassword is missing
        # Remove newPassword field from request
        * remove updateUserPasswordNoLogin.newPassword
        # Steps to update user's password without logged in without newPassword field
        * call read('../../core-services/pretests/eGovUserUpdatePretest.feature@errorInUpdatePasswordNoLogin')
        # Validate actual error retured by API should equal to expected error messages
        * match updatedPasswordWithOutLogin['error'].message == errorMessage.errormessages.invalidOTP

@Update_NoLogin_Password_NoUserName_05 @coreServices @regression @negative @userPasswordNoLogin @eGovUser
Scenario: To validate error message when username is missing
        # Remove userName field from request
        * remove updateUserPasswordNoLogin.userName
        # Steps to update user's password without logged in without userName field
        * call read('../../core-services/pretests/eGovUserUpdatePretest.feature@errorInUpdatePasswordNoLogin')
        # Validate actual error retured by API should equal to expected error messages
        * match updatedPasswordWithOutLogin['error'].message == errorMessage.errormessages.invalidOTP

@Update_NoLogin_Password_NotenantId_06 @coreServices @regression @negative @userPasswordNoLogin @eGovUser
Scenario: To validate error message when tenantId is missing
        # Remove userName field from request
        * remove updateUserPasswordNoLogin.tenantId
        # Steps to update user's password without logged in without tenantId field
        * call read('../../core-services/pretests/eGovUserUpdatePretest.feature@errorInUpdatePasswordNoLogin')
        # Validate actual error retured by API should equal to expected error messages
        * match updatedPasswordWithOutLogin['error'].message == errorMessage.errormessages.invalidOTP

@Update_NoLogin_Password_Notype_07 @coreServices @regression @negative @userPasswordNoLogin @eGovUser
Scenario: To validate error message when type is missing
        # Remove type field from request
        * remove updateUserPasswordNoLogin.type
        # Steps to update user's password without logged in without type field
        * call read('../../core-services/pretests/eGovUserUpdatePretest.feature@errorInUpdatePasswordNoLogin')
        # Validate actual error retured by API should equal to expected error messages
        * match updatedPasswordWithOutLogin['error'].message == errorMessage.errormessages.invalidOTP

@Update_NoLogin_Password_InValidUserName_08 @coreServices @regression @negative @userPasswordNoLogin @eGovUser
Scenario: To validate error message when userName is invalid
        # Set invalid value to the userName field 
        * set updateUserPasswordNoLogin.userName = ranString(10)
        # Steps to update user's password without logged in 
        * call read('../../core-services/pretests/eGovUserUpdatePretest.feature@errorInUpdatePasswordNoLogin')
        # Validate actual error retured by API should equal to expected error messages for invalid userName
        * match updatedPasswordWithOutLogin.Errors[0].code == errorMessage.errormessages.userNotFoundCode

@Update_NoLogin_Password_InValidtenantId_09 @coreServices @regression @negative @userPasswordNoLogin @eGovUser
Scenario: To validate error message when tenantId is invalid
        # Set invalid value to the tenantId field 
        * set updateUserPasswordNoLogin.tenantId = ranString(10)
        # Steps to update user's password without logged in 
        * call read('../../core-services/pretests/eGovUserUpdatePretest.feature@errorInUpdatePasswordNoLogin')
        # Validate actual error retured by API should equal to expected error messages for invalid tenantId
        # * print updatedPasswordWithOutLogin
        * match updatedPasswordWithOutLogin.Errors[0].code == errorMessage.errormessages.userNotFoundCode

     