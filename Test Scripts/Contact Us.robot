# ====================================================================================================
*** Settings ***
Documentation    Contact Us fields validation and functionalities.
...              
...              Test Environment: *${global_env}*
Resource    ../Resources/imports.resource
Test Tags    Regression
Suite Setup    Go to Wallet Codes Website    ${global_env}    chrome    10s    
Suite Teardown    End Testing
# ====================================================================================================



# ====================================================================================================
*** Variables ***
${messages}    Hello from the otter side UwU
${checkContactUs}    /support/contact-us
# ====================================================================================================



# ====================================================================================================
*** Test Cases ***
C10001 Submit with empty fields
    [Documentation]    Submit Contact Us form by leaving fields blank.
    [Tags]    Staging    Preprod    Production    Global    Taiwan    Flaky    NeedToChange
    Contact Us Setup
    Verify for Empty Fields
    Fill All Fields Except First Name
    Verify for Empty Fields

C10002 Submit with invalid email
    [Documentation]    Submit Contact Us form with invalid email and verify the error.
    [Tags]    Staging    Preprod    Production    Global    Taiwan    Flaky    NeedToChange
    @{invalid_emails}    Create Invalid Emails List
    Contact Us Setup
    Verify Invalid Email    @{invalid_emails}

C10003 Submit with invalid phone number
    [Documentation]    Submit Contact Us form with invalid phone number and verify the error.
    [Tags]    Staging    Preprod    Production    Global    Taiwan    Flaky    NeedToChange
    @{invalid_phones}    Create Invalid Phone Numbers List
    Contact Us Setup
    Verify Invalid Phone Number    @{invalid_phones}

C10004 Submit without recaptcha
    [Documentation]    Submit Contact Us form without resolving recaptcha.
    [Tags]    Staging    Preprod    Production    Global    Taiwan    Flaky
    Contact Us Setup
    Fill All Fields with Valid Data
    Wait For Recaptcha To Be Shown
    Pause For 3 Seconds
    Submit Contact Us Form
    Verify Error Recaptcha Must Be Solved

C10022 Submit with Valid Data
    [Documentation]    Submit Contact Us form with valid data.
    [Tags]    Staging    Preprod    Production    Global    Taiwan
    # Fill all fields with valid data
    IF    $checkStaging in $url_usedUrl or $checkPreprod in $url_usedUrl
        Contact Us Setup
        Fill All Fields with Valid Data
        Wait For Recaptcha To Be Shown
        Execute Manual Step    Please bypass recaptcha
        Verify Successfully Submit Message

        # Fill all fields except Inquiry
        Fill All Fields Except Inquiry
        Wait For Recaptcha To Be Shown
        Execute Manual Step    Please bypass recaptcha
        Verify Successfully Submit Message
    ELSE IF    $checkStaging not in $url_usedUrl and $checkPreprod not in $url_usedUrl
        Skip    This test case is unavailable for Production.
    END
# ====================================================================================================



# ====================================================================================================
*** Keywords ***
Go to Contact Us Page
    [Documentation]    Redirect user to Contact Us form submission page.
    Wait Until Keyword Succeeds    10s    1s    Mouse Over    ${drd_contactUsTop}
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${opt_contactUs}
    Wait Until Element Is Visible    ${unq_contactUs}

Fill All Fields with Valid Data
    [Documentation]    Fill all fields in contact us form with valid data.
    Wait Until Keyword Succeeds    10s    1s    Input Text    ${inp_firstName}    ${valid_firstName}
    Wait Until Keyword Succeeds    10s    1s    Input Text    ${inp_lastName}    ${valid_lastName}
    Wait Until Keyword Succeeds    10s    1s    Input Text    ${inp_phoneNumberContactUs}    ${valid_phoneNumber}
    Wait Until Keyword Succeeds    10s    1s    Input Text    ${inp_emailContactUs}    ${valid_email}
    Click Element    ${drd_inquiry}
    Click Element    ${opt_feedback}
    Wait Until Keyword Succeeds    10s    1s    Input Text    ${inp_messageContactUs}    ${messages}

Fill All Fields Except Inquiry
    [Documentation]    Fill all fields in contact us form except inquiry field. Test data being used is valid.
    Wait Until Keyword Succeeds    10s    1s    Input Text    ${inp_firstName}    ${valid_firstName}
    Wait Until Keyword Succeeds    10s    1s    Input Text    ${inp_lastName}    ${valid_lastName}
    Wait Until Keyword Succeeds    10s    1s    Input Text    ${inp_phoneNumberContactUs}    ${valid_phoneNumber}
    Wait Until Keyword Succeeds    10s    1s    Input Text    ${inp_emailContactUs}    ${valid_email}
    Wait Until Keyword Succeeds    10s    1s    Input Text    ${inp_messageContactUs}    ${messages}

Fill All Fields Except First Name
    [Documentation]    Fill all fields in contact us form except first name field. Test data being used is valid.
    Wait Until Keyword Succeeds    10s    1s    Input Text    ${inp_lastName}    ${valid_lastName}
    Wait Until Keyword Succeeds    10s    1s    Input Text    ${inp_phoneNumberContactUs}    ${valid_phoneNumber}
    Wait Until Keyword Succeeds    10s    1s    Input Text    ${inp_emailContactUs}    ${valid_email}
    Click Element    ${drd_inquiry}
    Click Element    ${opt_feedback}
    Wait Until Keyword Succeeds    10s    1s    Input Text    ${inp_messageContactUs}    ${messages}

Verify for Empty Fields
    [Documentation]    Assertion to verify whether system return error upon emptying all fields.
    Click Element    ${btn_submitMessage}
    Sleep    1s
    Wait Until Page Contains Element    ${err_emptyFieldsContactUs}
    Run Keyword And Continue On Failure    Click Element    ${err_emptyFieldsContactUs}
    
Verify Invalid Email
    [Documentation]    Assertion to verify whether system return error upon inputting invalid
    ...                email in email field or not. 
    [Arguments]    @{invalid_emails}
    FOR    ${email}    IN    @{invalid_emails}
        Wait Until Keyword Succeeds    10s    1s    Input Text    ${inp_emailContactUs}    ${email}
        Scroll Element Into View    ${unq_copyright}
        Click Element    ${btn_submitMessage}
        ${scrollPosition}=    Execute Javascript    return window.document.documentElement.scrollTop  
        Run Keyword And Continue On Failure    Should Be Equal As Integers    ${scrollPosition}    414
        Run Keyword And Continue On Failure    Element Should Not Be Visible    ${unq_successSubmitContactUs}
    END
    
Verify Invalid Phone Number
    [Documentation]    Assertion to verify whether system return error upon inputting invalid
    ...                phone number in phone number field or not. 
    [Arguments]    @{invalid_numbers}
    FOR    ${number}    IN    @{invalid_numbers}
        Wait Until Keyword Succeeds    10s    1s    Input Text    ${inp_phoneNumberContactUs}    ${number}
        Scroll Element Into View    ${unq_copyright}
        Click Element    ${btn_submitMessage}
        ${scrollPosition}=    Execute Javascript    return window.document.documentElement.scrollTop  
        Run Keyword And Continue On Failure    Should Be Equal As Integers    ${scrollPosition}    414
        Run Keyword And Continue On Failure    Element Should Not Be Visible    ${unq_successSubmitContactUs}
    END

Verify Successfully Submit Message
    [Documentation]    Assertion to verify whether system return notification that indicates
    ...                message is successfully submitted or not.
    Click Element    ${btn_submitMessage}
    Wait Until Page Contains Element    ${unq_successSubmitContactUs}    10s

Create Invalid Emails List
    [Documentation]    Return list of invalid emails.
    @{invalid_emails}    Create List    ${invalid_email1}    ${invalid_email2}    ${invalid_email3}    
    ...    ${invalid_email4}    ${invalid_email5}    ${invalid_email6}    ${invalid_email7}    ${invalid_email8}
    RETURN    ${invalid_emails}

Create Invalid Phone Numbers List
    [Documentation]    Return list of invalid phone numbers.
    @{invalid_phones}    Create List    ${invalid_phone1}    ${invalid_phone2}    ${invalid_phone3}
    RETURN    ${invalid_phones}

Wait For Recaptcha To Be Shown
    [Documentation]    Return list of invalid emails.
    Wait Until Page Contains Element    ${unq_recaptchaContactUs}

Pause For ${time}
    [Documentation]    Delay automation from executing next step for certain times. Wait Until Keyword Succeeds    10s    1s    Input is in seconds.
    Sleep    ${time}

Submit Contact Us Form
    [Documentation]    Click on submit form button in contact us form.
    Click Element    ${btn_submitMessage}

Verify Error Recaptcha Must Be Solved
    [Documentation]    Assertion to check whether error message is shown upon not resolving recaptcha.
    Pause for 1 second
    Element Should Be Visible    ${err_unverifyRecaptchaContactUs}

Contact Us Setup
    [Documentation]    Configuration before executing test steps in Contact Us suite.
    ${currentUrl}    Get Location
    IF    $checkContactUs not in $currentUrl
        Check If This is Taiwan Website
        Go to Contact Us Page
    ELSE
        Reload Page
        Wait Until Element Is Visible    ${unq_contactUs}
    END
# ====================================================================================================