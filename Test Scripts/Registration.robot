# ====================================================================================================
*** Settings ***
Documentation    Automation script for Registration.
...              
...              Test Environment: *${global_env}*
Resource    ../Resources/imports.resource
Test Tags    Regression
Suite Setup    Go to Wallet Codes Website    ${global_env}    chrome    10s
Suite Teardown    End Testing
# ====================================================================================================



# ====================================================================================================
*** Variables ***
${checkRegisterPage}    /profile/register
# ====================================================================================================



# ====================================================================================================
*** Test Cases ***
C10141 Register with invalid email
    [Documentation]    Register new account with only inputting email field with invalid emails.
    [Tags]    Staging    Preprod    Production    Global    Taiwan
    @{emails}    Create Invalid Emails List
    Registration Setup
    Verify Invalid Email in Registration Page    @{emails}

C10142 Register with invalid password
    [Documentation]    Register new account with only inputting password field with invalid passwords.
    [Tags]    Staging    Preprod    Production    Global    Taiwan
    @{passwords}    Create Invalid Passwords List
    Registration Setup
    Verify Invalid Password in Registration Page    @{passwords}

C10143 Register with empty fields
    [Documentation]    Register new account with emptying fields.
    [Tags]    Staging    Preprod    Production    Global    Taiwan
    Registration Setup
    Empty All Fields Without Resolving Recaptcha
    Verify Empty Fields in Registration Page for Alert Error Message
    Fill Password And Empty The Rest Without Resolving Recaptcha
    Verify Empty Fields in Registration Page for Alert Error Message
    Clear Password Field
    Fill Email And Empty The Rest Without Resolving Recaptcha
    Verify Empty Fields in Registration Page for Alert Error Message
    Clear Email Field
    Fill Name And Empty The Rest With Resolving Recaptcha
    Verify Empty Fields in Registration Page for All Error Message

C10144 Registration page CTA
    [Documentation]    Register page CTAs functionality.
    [Tags]    Staging    Preprod    Production    Global    Taiwan
    Registration Setup
    Go to Log In CTA in Registration Page
    Go to Registration Page
    Go to What is P Point in Registration Page

C10145 Register with already registered email
    [Documentation]    Register new account with duplicate credentials including phone number for Taiwan website.
    [Tags]    Staging    Preprod    Production    Global    Taiwan
    Registration Setup
    Fill Registration Form With Duplicate Account
    Verify Duplicate Account Error Message
    
C10150 Register without verify recaptcha
    [Documentation]    Register new account with valid data but doesn't resolve the recaptcha.
    [Tags]    Staging    Preprod    Production    Global    Taiwan
    Registration Setup
    Fill Name, Email and Password Then Submit Without Recaptcha
    Verify Error Message For Recaptcha is not Resolved

C10736 Register with invalid phone number
    [Documentation]    Register new account with only inputting phone number field with invalid numbers.
    [Tags]    Staging    Preprod    Production    Taiwan
    IF    $checkTaiwan in $url_usedUrl
        @{phones}    Create Invalid Phone Numbers List
        Registration Setup
        Verify Invalid Phone in Registration Page    @{phones}
    ELSE
        Skip    Not testing Taiwan website.
    END

C10737 Register without phone number and DoB
    [Documentation]    Register new account with only inputting name,email and password field without filling out
    ...    the rest of the fields.
    [Tags]    Staging    Preprod    Production    Taiwan
    IF    $checkTaiwan in $url_usedUrl
        Registration Setup
        Fill Name, Email and Password Then Submit With Recaptcha
        Verify Empty Fields in Registration Page for Alert Error Message
        Verify Empty Fields in Registration Page for Phone Error Message
    ELSE
        Skip    Not testing Taiwan website.
    END
# ====================================================================================================
    


# ====================================================================================================
*** Keywords ***
Go to Registration Page
    [Documentation]    Redirect user to registration page.
    IF    $checkStaging in $url_usedUrl or $checkPreprod in $url_usedUrl
        Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_registerTop}
        IF    $checkTaiwan not in $url_usedUrl
            Wait Until Element Is Visible    ${unq_registrationPage}
        ELSE IF    $checkTaiwan in $url_usedUrl
            Wait Until Element Is Visible    ${unq_registrationPageTW}
        END
    ELSE IF    $checkStaging not in $url_usedUrl and $checkPreprod not in $url_usedUrl
        IF    $checkTaiwan not in $url_usedUrl
            Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_registerTop2}
        ELSE IF    $checkTaiwan in $url_usedUrl
            Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_registerTop}
        END
        Wait Until Element Is Visible    ${unq_registrationPage}
    END
    
Registration Setup
    [Documentation]    Configuration before executing test steps in Registration test suite.
    Check If This is Taiwan Website
    ${currentUrl}    Get Location
    IF    $checkRegisterPage in $currentUrl
        Reload Page
        Wait Until Element Is Visible    ${inp_emailRegister}
    ELSE
        Go to Registration Page
    END

Empty All Fields Without Resolving Recaptcha
    [Documentation]    Let all fields empty and proceed without resolving recaptcha.
    Input Registration Form    recaptcha=${False}

Fill Password And Empty The Rest Without Resolving Recaptcha
    [Documentation]    Input password field and let the rest empty then proceed without resolving recaptcha.
    Input Registration Form    password=${valid_password}    recaptcha=${False}

Clear Password Field
    [Documentation]    Make password field to be blank.
    Clear Form Input    ${inp_passwordRegister}

Fill Email And Empty The Rest Without Resolving Recaptcha
    [Documentation]    Input email field and let the rest empty then proceed without resolving recaptcha.
    Input Registration Form    email=${valid_email}    recaptcha=${False}

Clear Email Field
    [Documentation]    Make email field to be blank.
    Clear Form Input    ${inp_emailRegister}

Fill Name And Empty The Rest With Resolving Recaptcha
    [Documentation]    Input name field and let the rest empty then proceed with resolving recaptcha.
    Input Registration Form    name=${valid_name}

Fill Name, Email and Password Then Submit Without Recaptcha
    [Documentation]    Input name, email and passwords fields and let the rest empty then proceed without resolving recaptcha.
    Input Registration Form    ${valid_name}    ${valid_email2}    ${valid_password}    Only Wait

Fill Name, Email and Password Then Submit With Recaptcha
    [Documentation]    Input name, email and passwords fields and let the rest empty then proceed with resolving recaptcha.
    Input Registration Form    ${valid_name}    ${valid_email2}    ${valid_password}

Go to Log In CTA in Registration Page
    [Documentation]    Redirect user to Login page through CTA in Registration page.
    IF    $checkStaging in $url_usedUrl or $checkPreprod in $url_usedUrl
        IF    $checkTaiwan not in $url_usedUrl
            Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_loginRegister}
            Wait Until Element Is Visible    ${unq_loginPage}
        ELSE IF    $checkTaiwan in $url_usedUrl
            Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_loginRegisterTW}
            Wait Until Element Is Visible    ${unq_loginPage2}
        END
    ELSE IF    $checkStaging not in $url_usedUrl and $checkPreprod not in $url_usedUrl
        IF    $checkTaiwan not in $url_usedUrl
            Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_loginRegister2}
            Wait Until Element Is Visible    ${unq_loginPage2}
        ELSE IF    $checkTaiwan in $url_usedUrl
            Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_loginRegisterTW2}
            Wait Until Element Is Visible    ${unq_loginPage}
        END
    END

Go to What is P Point in Registration Page
    [Documentation]    Redirect user to P Point support page through CTA in Registration page.
    IF    $checkTaiwan not in $url_usedUrl
        Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_whatIsPpointRegister}
    ELSE IF    $checkTaiwan in $url_usedUrl
        IF    $checkStaging in $url_usedUrl or $checkPreprod in $url_usedUrl
            Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_whatIsPpointRegisterTW}
        ELSE
            Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_whatIsPpointRegister}
        END
    END
    Element Should Be Visible    ${unq_whatIsPPoints}

Fill Registration Form With Duplicate Account
    [Documentation]    Input email with already registered email.
    IF    $checkTaiwan not in $url_usedUrl
        Input Registration Form    ${valid_name}    ${valid_email2}    ${valid_password}
    ELSE IF    $checkTaiwan in $url_usedUrl
        Input Taiwan Registration Form    ${valid_name}    ${valid_email2}    ${valid_password}
        ...    ${valid_phoneNumber}    ${valid_DoB_YYYYMMDD}
    END

Verify Duplicate Account Error Message
    [Documentation]    Assertion for error message that indicates credentials being registered is already in
    ...                the system.
    IF    $checkStaging in $url_usedUrl or $checkPreprod in $url_usedUrl
        IF    $checkTaiwan not in $url_usedUrl
            Wait Until Element Is Visible    ${err_duplicateAccount}
        ELSE IF    $checkTaiwan in $url_usedUrl
            Wait Until Element Is Visible    ${err_duplicateAccount2}
        END
    ELSE IF    $checkStaging not in $url_usedUrl and $checkPreprod not in $url_usedUrl
        Wait Until Element Is Visible    ${err_duplicateAccount2}
    END

Verify Error Message For Recaptcha is not Resolved
    [Documentation]    Assertion for error message that indicates recaptcha is not solved.
    Sleep    0.5s
    Element Should Be Visible    ${err_unverifyRecaptcha}

Verify Invalid Email in Registration Page
    [Documentation]    Assertion for verify whether inputted email is invalid or not.
    [Arguments]    @{emails}
    FOR    ${email}    IN    @{emails}
        Wait Until Keyword Succeeds    10s    1s    Input Text    ${inp_emailRegister}    ${email}
        Run Keyword And Continue On Failure    Element Should Be Visible    ${err_invalidEmailRegister}
    END

Verify Invalid Password in Registration Page
    [Documentation]    Assertion for verify whether inputted password is invalid or not.
    [Arguments]    @{passwords}
    FOR    ${password}    IN    @{passwords}
        Clear Form Input    ${inp_passwordRegister}
        Wait Until Keyword Succeeds    10s    1s    Input Text    ${inp_passwordRegister}    ${password}
        Run Keyword And Continue On Failure    Element Should Be Visible    ${err_invalidPasswordRegister}
    END

Verify Invalid Phone in Registration Page
    [Documentation]    Assertion for verify whether inputted phone is invalid or not.
    [Arguments]    @{phones}
    FOR    ${phone}    IN    @{phones}
        Wait Until Keyword Succeeds    10s    1s    Input Text    ${inp_phoneNumberRegister}    ${phone}
        Run Keyword And Continue On Failure    Element Should Be Visible    ${err_invalidPhoneNumberRegister}
    END

Input Registration Form
    [Documentation]    Fill out all fields in registration page for Non-Taiwan website.
    ...                Default value of each parameter is empty, you can select which field going to be
    ...                filled out. ${recaptcha} can be filled by ${False} if you want to skip manual 
    ...                bypass recaptcha. If you filled it with "Only Wait", it will only waiting until
    ...                recaptcha element is visible.
    [Arguments]    ${name}=${EMPTY}    ${email}=${EMPTY}    ${password}=${EMPTY}    ${recaptcha}=${True}
    Wait Until Keyword Succeeds    10s    1s    Input Text    ${inp_nameRegister}    ${name}
    Wait Until Keyword Succeeds    10s    1s    Input Text    ${inp_emailRegister}    ${email}
    Wait Until Keyword Succeeds    10s    1s    Input Text    ${inp_passwordRegister}    ${password}
    IF    $recaptcha==$True
        Wait Until Element Is Visible    ${unq_recaptchaContactUs}
        Execute Manual Step    Please bypass recaptcha
    ELSE IF    $recaptcha=='Only Wait'
        Wait Until Element Is Visible    ${unq_recaptchaContactUs}
    END
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_submitRegister}

Input Taiwan Registration Form
    [Documentation]    Fill out all fields in registration page for Taiwan website.
    ...                Default value of each parameter is empty, you can select which field going to be
    ...                filled out. ${recaptcha} can be filled by ${False} if you want to skip manual 
    ...                bypass recaptcha. If you filled it with "Only Wait", it will only waiting until
    ...                recaptcha element is visible.
    [Arguments]    ${name}=${EMPTY}    ${email}=${EMPTY}    ${password}=${EMPTY}    ${phonenumber}=${EMPTY}
    ...    ${DoB}=${EMPTY}    ${recaptcha}=${True}
    Wait Until Keyword Succeeds    10s    1s    Input Text    ${inp_nameRegister}    ${name}
    Wait Until Keyword Succeeds    10s    1s    Input Text    ${inp_emailRegister}    ${email}
    Wait Until Keyword Succeeds    10s    1s    Input Text    ${inp_passwordRegister}    ${password}
    Wait Until Keyword Succeeds    10s    1s    Input Text    ${inp_phoneNumberRegister}    ${phonenumber}
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${inp_DoBRegister}
    Press Keys    ${inp_DoBRegister}    ${DoB}
    IF    $recaptcha==$True
        Wait Until Element Is Visible    ${unq_recaptchaContactUs}
        Execute Manual Step    Please bypass recaptcha
    ELSE IF    $recaptcha=='Only Wait'
        Wait Until Element Is Visible    ${unq_recaptchaContactUs}
    END
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_submitRegister}

Verify Empty Fields in Registration Page for ${error message} Error Message
    [Documentation]    Verify whether fields are empty or not by checking
    ...                if there's any error message or not. ${error message} can be filled by "Alert" for
    ...                only check alert. "Both" for email and password error message under its field.
    ...                "Email" for email under its field only. "Password" for password. "Phone" for phone number.
    ...                "All" for all types of error message in registration page for empty field.
    Sleep    1s
    IF    $error_message=="Alert"
        Run Keyword And Continue On Failure    Element Should Be Visible    ${err_emptyFieldRegister}
        Wait Until Keyword Succeeds    10s    1s    Click Element    ${err_emptyFieldRegister}
    ELSE IF    $error_message=="Email"
        Run Keyword And Continue On Failure    Element Should Be Visible    ${err_emptyEmailRegister}
    ELSE IF    $error_message=="Password"
        Run Keyword And Continue On Failure    Element Should Be Visible    ${err_emptyPasswordRegister}
    ELSE IF    $error_message=="Phone"
        Run Keyword And Continue On Failure    Element Should Be Visible    ${err_emptyPhoneNumberRegister}
    ELSE IF    $error_message=="Both"
        Run Keyword And Continue On Failure    Element Should Be Visible    ${err_emptyEmailRegister}
        Run Keyword And Continue On Failure    Element Should Be Visible    ${err_emptyPasswordRegister}
    ELSE IF    $error_message=="All"
        Run Keyword And Continue On Failure    Element Should Be Visible    ${err_emptyFieldRegister}
        Run Keyword And Continue On Failure    Element Should Be Visible    ${err_emptyEmailRegister}
        Run Keyword And Continue On Failure    Element Should Be Visible    ${err_emptyPasswordRegister}
        Wait Until Keyword Succeeds    10s    1s    Click Element    ${err_emptyFieldRegister}
    END

Create Invalid Emails List
    [Documentation]    Return list of invalid emails.
    @{emails}    Create List    ${invalid_email1}    ${invalid_email2}    ${invalid_email3}    ${invalid_email4}
    ...    ${invalid_email5}    ${invalid_email6}    ${invalid_email7}    ${invalid_email8}
    RETURN    ${emails}

Create Invalid Passwords List
    [Documentation]    Return list of invalid passwords.
    @{passwords}    Create List    ${invalid_password1}    ${invalid_password2}    ${invalid_password3}
    ...    ${invalid_password4}    ${invalid_password5}    ${invalid_password6}
    RETURN    ${passwords}

Create Invalid Phone Numbers List
    [Documentation]    Return list of invalid phone numbers.
    @{phones}    Create List    ${invalid_phone1}    ${invalid_phone2}    ${invalid_phone3} 
        ...    ${invalid_phone4}
    RETURN    ${phones}
# ====================================================================================================