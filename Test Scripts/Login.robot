# ====================================================================================================
*** Settings ***
Documentation    Login fields validation and functionalities.
...              
...              Test Environment: *${global_env}*
Resource    ../Resources/imports.resource
Test Tags    Regression
Suite Setup    Go to Wallet Codes Website    ${global_env}    chrome    10s
Suite Teardown    End Testing
# ====================================================================================================



# ====================================================================================================
*** Variables ***
${checkLogin}    /profile/login
# ====================================================================================================



# ====================================================================================================
*** Test Cases ***
C10146 Login with incorrect credentials
    [Documentation]    Inputting invalid credentials in login page.
    [Tags]    Staging    Preprod    Production    Global    Taiwan
    Login Setup
    Fill Out With Incorrect Credentials
    Verify Invalid Credentials in Login Page
    Verify Field Invalid Credentials For Both Error Message

C10148 Login with unregistered credentials
    [Documentation]    Inputting unregistered credentials in login page.
    [Tags]    Staging    Preprod    Production    Global    Taiwan
    Login Setup
    Fill Out With Unregistered Email
    Verify Invalid Credentials in Login Page
    Verify Field Invalid Credentials For Both Error Message

C10149 Login with unverified email
    [Documentation]    Inputting unverified credentials in login page.
    [Tags]    NeedToChange    Staging    Preprod    Production    Global    Taiwan
    Login Setup
    Fill Out With Unverified Account
    Verify Unverified Account Error Message
    
C10151 Login without recaptcha
    [Documentation]    Inputting valid credentials in login page then login without resolving recaptcha.
    [Tags]    Staging    Preprod    Production    Global    Taiwan
    Login Setup
    Fill Out With Unregistered Email and Submit Without Recaptcha
    Verify Unresolved Recaptcha Error Message

C10152 Login with empty fields
    [Documentation]    Inputting empty fields upon logging in.
    [Tags]    Staging    Preprod    Production    Global    Taiwan    Flaky
    Login Setup
    Empty All Fields and Submit Without Recaptcha
    Check For Anomaly Error Message Upon Emptying Fields
    Verify Empty Fields Error Message
    Empty Email and Fill Out Password Then Submit Without Recaptcha
    Verify Empty Fields Error Message
    Clear Password Field
    Empty Password and Fill Out Email Then Submit With Recaptcha
    Verify Password Required Error Message

C10153 Login page CTA
    [Documentation]    Login page CTAs functionality.
    [Tags]    Staging    Preprod    Production    Global    Taiwan
    Login Setup
    Go To Registration Page via Login Page
    Go To What is P Points Page via Login Page   

C10161 Login with valid data
    [Documentation]    Logging in with valid credentials.
    [Tags]    Staging    Preprod    Production    Global    Taiwan
    Login Setup
    Fill Out With Correct Credentials
    Close Modal Pop-up                        # Sometimes it's shown in Taiwan Production 
    Verify Successfully Logged In
# ====================================================================================================



# ====================================================================================================
*** Keywords ***
Login Setup
    [Documentation]    Configuration before executing test steps in Login suite.
    Check If This is Taiwan Website
    ${currentUrl}    Get Location
    IF    $checkLogin in $currentUrl
        Reload Page
        Wait Until Element Is Visible    ${inp_emailLogin}
    ELSE
        ${before}    Get Selenium Implicit Wait
        Set Selenium Implicit Wait    1s
        ${logged_in}    Run Keyword And Return Status    Element Should Be Visible    ${drd_myAccountsTop}
        Set Selenium Implicit Wait    ${before}
        IF    $logged_in
            Wait Until Keyword Succeeds    10s    1s    Mouse Over    ${drd_myAccountsTop}
            Wait Until Keyword Succeeds    10s    1s    Click Element    ${opt_logout}
            Wait Until Page Does Not Contain Element    ${drd_myAccountsTop}    1s
        END
        Go to Login Page
    END

Go to Login Page
    [Documentation]    Redirect user to Login page.
    IF    $checkStaging in $url_usedUrl or $checkPreprod in $url_usedUrl
        Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_loginTop}
        IF    $checkTaiwan not in $url_usedUrl
            Wait Until Element Is Visible    ${unq_loginPage}
        ELSE IF    $checkTaiwan in $url_usedUrl
            Wait Until Element Is Visible    ${unq_loginPage2}
        END
    ELSE IF    $checkStaging not in $url_usedUrl and $checkPreprod not in $url_usedUrl
        IF    $checkTaiwan not in $url_usedUrl
            Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_loginTop2}
            Wait Until Element Is Visible    ${unq_loginPage2}
        ELSE IF    $checkTaiwan in $url_usedUrl
            Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_loginTop}
            Wait Until Element Is Visible    ${unq_loginPage}
        END
    END

Input Login credentials
    [Documentation]    Fill out email and password fields. Default value is empty, you can input desired value
    ...                respectively. If $recaptcha is True, it will wait for recaptcha to show. Otherwise, it
    ...                will be skipped.
    [Arguments]    ${email}=${EMPTY}    ${password}=${EMPTY}    ${recaptcha}=${True}
    Wait Until Keyword Succeeds    10s    1s    Input Text    ${inp_emailLogin}    ${email}
    Wait Until Keyword Succeeds    10s    1s    Input Text    ${inp_passwordLogin}    ${password}
    IF    $recaptcha == True
        Wait Until Element Is Visible    ${unq_recaptchaContactUs}
        Execute Manual Step    Please bypass recaptcha       
    ELSE IF    $recaptcha == 'Only Wait'
        Wait Until Element Is Visible    ${unq_recaptchaContactUs}
    END
    ${before}    Get Selenium Implicit Wait
    Set Selenium Implicit Wait    1s
    ${login_button}    Run Keyword And Return Status    Element Should Be Visible    ${btn_submitLogin}
    Set Selenium Implicit Wait    ${before}
    IF    $login_button
        Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_submitLogin}
    ELSE
        Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_tryAgainLogin}        
    END

Fill Out With Incorrect Credentials
    [Documentation]    Fill email field with registered email and password field with unmatched password.
    Input Login credentials    ${valid_email2}    ${valid_password2}

Fill Out With Unregistered Email
    [Documentation]    Fill email field with unregistered email and password field with any password.
    Input Login credentials    ${unregistered_email}    ${valid_password2}

Fill Out With Unregistered Email and Submit Without Recaptcha
    [Documentation]    Fill email field with unregistered email and password field with any password then submit
    ...                without solving recaptcha.
    Input Login credentials    ${unregistered_email}    ${valid_password}    Only Wait

Fill Out With Unverified Account
    [Documentation]    Fill email field with unverified email and password field with matched password.
    Input Login credentials    ${unverified_email}    ${valid_password}

Fill Out With Correct Credentials
    [Documentation]    Fill email field with valid email and password field with matched password.
    Input Login credentials    ${valid_email2}    ${valid_password}

Empty All Fields and Submit Without Recaptcha
    [Documentation]    Empty all field and submit without solving the recaptcha.
    Input Login credentials    recaptcha=${False}

Empty Email and Fill Out Password Then Submit Without Recaptcha
    [Documentation]    Empty email field but fill out password field and submit without solving the recaptcha.
    Input Login credentials    password=${valid_password}    recaptcha=${False}

Empty Password and Fill Out Email Then Submit With Recaptcha
    [Documentation]    Empty password field but fill out email field and solving the recaptcha before submit.
    Input Login credentials    email=${valid_email}

Clear Password Field
    [Documentation]    Empty password field in login page.
    Clear Form Input    ${inp_passwordLogin}

Verify Field Invalid Credentials For ${error message} Error Message
    [Documentation]    Assertion to verify whether credentials inputted is invalid or not
    ...                by checking the error message shown under a field. You can select either email 
    ...                or password that should be invalid or both by inputting "Email", "Password" or "Both".
    IF    $error_message == "Both"
        Run Keyword And Continue On Failure    Element Should Be Visible    ${err_invalidEmailLogin}
        Run Keyword And Continue On Failure    Element Should Be Visible    ${err_invalidPasswordLogin}
    ELSE IF    $error_message == "Email"
        Run Keyword And Continue On Failure    Element Should Be Visible    ${err_invalidEmailLogin}
    ELSE IF    $error_message == "Password"
        Run Keyword And Continue On Failure    Element Should Be Visible    ${err_invalidPasswordLogin}
    END

Check For Anomaly Error Message Upon Emptying Fields
    [Documentation]    Sometimes error message has different copy, this will fail test cases. So, putting
    ...                this will prevent test case for failing.
    Sleep    1s
    ${before}    Get Selenium Implicit Wait
    Set Browser Implicit Wait    1s
    ${anomaly}    Run Keyword And Return Status    Element Should Be Visible    ${err_cannotEmptyFieldsLogin}
    IF    $anomaly
        Wait for Error Message and Proceed    ${err_cannotEmptyFieldsLogin}    wait=1s
        Input Login credentials    recaptcha=${False}
    END
    Set Browser Implicit Wait    ${before}

Verify Unverified Account Error Message
    [Documentation]    Assertion for error message that indicates account has not been verified.
    IF    $checkStaging in $url_usedUrl
        Close Modal Pop-up                        # Sometimes it's shown in Taiwan Production 
        Verify Successfully Logged In
    ELSE
        Wait for Error Message and Proceed    ${err_unverifiedCredentials}
        Verify Field Invalid Credentials For Both Error Message
    END

Verify Unresolved Recaptcha Error Message
    [Documentation]    Assertion for error message that indicates recaptcha has not been resolved.
    Wait for Error Message and Proceed    ${err_unverifyRecaptcha}

Verify Empty Fields Error Message
    [Documentation]    Assertion for error message that indicates fields are empty.
    Wait for Error Message and Proceed    ${err_emptyFieldsLogin}

Verify Password Required Error Message
    [Documentation]    Assertion for error message that password field is empty.
    Element Should Be Visible    ${err_requiredPasswordLogin}

Wait for Error Message and Proceed
    [Documentation]    Wait for inputted error message and click it.
    ...                Usually error message in form of alert need to be clicked. If don't need to click
    ...                the error message after it's shown, you can put False into $click parameter.
    [Arguments]    ${element}    ${click}=${True}    ${wait}=5s
    Wait Until Element Is Visible    ${element}    ${wait}
    IF    $click==$True
        Wait Until Keyword Succeeds    10s    1s    Click Element    ${element}        
    END

Verify Successfully Logged In
    [Documentation]    Assertion to verify whether credentials inputted is valid or not
    ...                by checking alert shown and current top menu.
    Wait Until Element Is Visible    ${unq_loggedIn}
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${unq_loggedIn}
    Element Should Be Visible    ${drd_myAccountsTop}
    IF    $checkTaiwan in $url_usedUrl
        IF    $checkStaging in $url_usedUrl or $checkPreprod in $url_usedUrl
            Element Should Be Visible    ${drd_myPointsTop}
        END
    ELSE 
        Element Should Be Visible    ${drd_mypPointsTop}
    END

Verify Invalid Credentials in Login Page
    [Documentation]    Assertion to verify whether credentials inputted is valid or not
    ...                by checking alert shown and current top menu.
    IF    $checkStaging in $url_usedUrl or $checkPreprod in $url_usedUrl
        IF    $checkTaiwan not in $url_usedUrl
            Wait for Error Message and Proceed    ${err_invalidCredentials}
        ELSE
            Wait for Error Message and Proceed    ${err_invalidCredentialsTW}
        END
    ELSE IF    $checkStaging not in $url_usedUrl and $checkPreprod not in $url_usedUrl
        Wait for Error Message and Proceed    ${err_invalidCredentials2}
    END

Go To Registration Page via Login Page
    [Documentation]    Redirect user to Registration page through CTA in login page.
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_signMeUpLogin}
    IF    $checkTaiwan in $url_usedUrl   
        IF    $checkStaging in $url_usedUrl or $checkPreprod in $url_usedUrl
            Element Should Be Visible    ${unq_registrationPageTW}
        ELSE
            Element Should Be Visible    ${unq_registrationPage}
        END
    ELSE
        Element Should Be Visible    ${unq_registrationPage}
    END

Go To What is P Points Page via Login Page
    [Documentation]    Redirect user to P Point support page through CTA in login page.
    IF    $checkTaiwan in $url_usedUrl
        IF    $checkStaging in $url_usedUrl or $checkPreprod in $url_usedUrl
            Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_whatIsPpointLoginTW}
        ELSE
            Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_whatIsPpointLogin}
        END
    ELSE
        Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_whatIsPpointLogin}
    END
    Element Should Be Visible    ${unq_whatIsPPoints}
# ====================================================================================================