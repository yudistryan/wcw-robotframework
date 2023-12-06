# ====================================================================================================
*** Settings ***
Documentation    Forgot password's email validation and sending email functionalities.
...              
...              Test Environment: *${global_env}*
Resource    ../Resources/imports.resource
Test Tags    Regression
Suite Setup    Go to Wallet Codes Website    ${global_env}    chrome    10s
Suite Teardown    End Testing
# ====================================================================================================



# ====================================================================================================
*** Variables ***
${checkForgotPassword}    /profile/forget-password
# ====================================================================================================



# ====================================================================================================
*** Test Cases ***
C10162 Input invalid emails
    [Documentation]    Submit Forgot Password by inputting invalid emails.
    [Tags]    Staging    Preprod    Production    Global    Taiwan
    @{emails}    Create Invalid Emails List
    Forgot Password Setup
    Verify Invalid Email in Forgot Password    @{emails}
    
C10163 Input unregistered email
    [Documentation]    Submit Forgot Password by inputting unregistered emails.
    [Tags]    Staging    Preprod    Production    Global    Taiwan
    Forgot Password Setup
    IF    $checkStaging in $url_usedUrl
        Input Unregistered Email
        Submit Forgot Password
        Verify Success Request Forgot Password
    ELSE
        Verify Invalid Email in Forgot Password    ${unregistered_email}
    END

C10164 Input registered email
    [Documentation]    Submit Forgot Password by inputting registered account's email.
    [Tags]    Staging    Preprod    Production    Global    Taiwan
    Forgot Password Setup
    Input Unverified Email
    Submit Forgot Password
    Verify Success Request Forgot Password
    Reload Page
    Input Verified Email
    Submit Forgot Password
    Verify Success Request Forgot Password
# ====================================================================================================



# ====================================================================================================
*** Keywords ***
Forgot Password Setup
    [Documentation]    Configuration before executing test steps in Forgot Password suite.
    ${currentUrl}    Get Location
    IF    $checkForgotPassword not in $currentUrl
        Check If This is Taiwan Website
        Go to Forgot Password Page
        ${succeed_UI}    Check For Email Sent Succeed UI
        IF    $succeed_UI
            Reload Page
        END
    ELSE
        Reload Page
        Wait Until Element Is Visible    ${unq_forgotPassword}
    END

Check For Email Sent Succeed UI
    [Documentation]    Return whether UI for successfully sent email is appeared or not in boolean.
    ${before}    Get Selenium Implicit Wait
    Set Selenium Implicit Wait    1s
    ${appeared}    Run Keyword And Return Status    Element Should Be Visible    ${unq_successForgotPassword}
    Set Selenium Implicit Wait    ${before}
    RETURN    ${appeared}

Go to Forgot Password Page
    [Documentation]    User is redirected to Forgot Password page.
    IF    $checkStaging in $url_usedUrl or $checkPreprod in $url_usedUrl
        Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_loginTop}
    ELSE IF    $checkStaging not in $url_usedUrl and $checkPreprod not in $url_usedUrl
        IF    $checkTaiwan not in $url_usedUrl
            Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_loginTop2}
        ELSE IF    $checkTaiwan in $url_usedUrl
            Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_loginTop}
        END
    END
    Wait Until Element Is Visible    ${unq_loginPage}
    IF    $checkStaging in $url_usedUrl or $checkPreprod in $url_usedUrl
        Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_forgetPasswordLogin}
    ELSE
        Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_forgetPasswordLogin2}
    END
    Wait Until Element Is Visible    ${unq_forgotPassword}

Verify Invalid Email in Forgot Password
    [Documentation]    Verify whether inputted email is invalid upon in forgot password page.
    ...                Argument can be either scalar or list.
    [Arguments]    @{emails}
    FOR    ${email}    IN    @{emails}
        ${succeed_UI}    Check For Email Sent Succeed UI
        IF    $succeed_UI
            Reload Page
        END
        Input Text    ${inp_emailLogin}    ${email}
        Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_submitForgotPassword}
        Run Keyword And Continue On Failure    Element Should Be Visible    ${err_invalidEmailLogin}
    END

Create Invalid Emails List
    [Documentation]    Return list of invalid emails.
    @{emails}    Create List    ${invalid_email1}    ${invalid_email2}    ${invalid_email3}    
    ...    ${invalid_email4}    ${invalid_email8}    ${invalid_email6}    ${invalid_email7}    
    # ...    ${invalid_email5}
    RETURN    ${emails}

Input ${email_type} Email
    [Documentation]    Input email field with desired email type. There are Unregistered, Unverified and 
    ...                Verified emails. E.g: Input Unverified Email.
    IF    $email_type == 'Unregistered'
        Wait Until Keyword Succeeds    10s    1s    Press Keys    ${inp_emailLogin}    ${unregistered_email}
    ELSE IF    $email_type == 'Unverified'
        Wait Until Keyword Succeeds    10s    1s    Press Keys    ${inp_emailLogin}    ${unverified_email}
    ELSE IF    $email_type == 'Verified'
        Wait Until Keyword Succeeds    10s    1s    Press Keys    ${inp_emailLogin}    ${valid_email6}
    END

Submit Forgot Password
    [Documentation]    Click on submit forgot password button.
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_submitForgotPassword}

Verify Success Request Forgot Password
    [Documentation]    Assertion to verify whether forgot password is successfully submitted.
    Element Should Be Visible    ${unq_successForgotPassword}
# ====================================================================================================