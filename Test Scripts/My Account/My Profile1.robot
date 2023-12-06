# ====================================================================================================
*** Settings ***
Documentation    My Profile test scripts for negative test cases.
...              
...              Test Environment: *${global_env}*
Resource    ../../Resources/imports.resource
Test Tags    Regression
Suite Setup    Go to Wallet Codes Website    ${global_env}    chrome    10s
Suite Teardown    End Testing
# ====================================================================================================



# ====================================================================================================
*** Variables ***
${checkMyProfile}    /my-account
# ====================================================================================================



# ====================================================================================================
*** Test Cases ***
C10007 Save with empty fields
    [Documentation]    Saving empty fields upon editing my profile for non-Taiwan website.
    [Tags]    Staging    Preprod    Production    Global
    My Profile Setup
    IF    $checkTaiwan not in $url_usedUrl
        Click on Edit in My Profile
        Clear Fields in My Profile Non Taiwan
        Save My Profile
        Verify Empty Fields in My Profile Non Taiwan
    ELSE
        Skip    This case only be tested for Non-Taiwan website.
    END

C10008 Save with invalid email
    [Documentation]    Saving invalid emails upon editing my profile for all website.
    [Tags]    Staging    Preprod    Production    Global    Taiwan
    @{invalid_emails}    Add Invalid Emails
    My Profile Setup
    Execution Settings    speed=0.25
    Click on Edit in My Profile
    Verify Invalid Email in My Profile    @{invalid_emails}
    Execution Settings    speed=0

C10009 Save with invalid password
    [Documentation]    Saving invalid passwords upon editing my profile for all website.
    [Tags]    Staging    Preprod    Production    Global    Taiwan
    @{invalid_passwords}    Add Invalid Passwords
    My Profile Setup
    Click on Edit in My Profile
    Verify Invalid Password in My Profile    @{invalid_passwords}

C10010 Cancel editing profile
    [Documentation]    Cancel saving upon editing my profile for all website.
    [Tags]    Staging    Preprod    Production    Global    Taiwan
    My Profile Setup
    Execution Settings    browser_implicit_wait=15s
    Click on Edit in My Profile
    Cancel Edit on My Profile
    Verify If Nothing's Changed After Cancelling

C10740 Save with empty fields for Taiwan
    [Documentation]    Saving empty fields upon editing my profile for Taiwan website.
    [Tags]    Staging    Preprod    Production    Taiwan
    IF    $checkTaiwan in $url_usedUrl
        My Profile Setup
        Click on Edit in My Profile
        Clear Fields in My Profile Taiwan
        Save My Profile
        Sleep    2s
        Verify Empty Fields in My Profile Taiwan
    ELSE
        Skip    This case only be tested in Taiwan website.
    END

C10739 Save with invalid phone number
    [Documentation]    Saving invalid phone numbers upon editing my profile for Taiwan website.
    [Tags]    Staging    Preprod    Production    Taiwan
    IF    $checkTaiwan in $url_usedUrl
        @{invalid_numbers}    Add Invalid Phone Numbers
        My Profile Setup
        Click on Edit in My Profile
        Verify Invalid Phone in Profile    ${invalid_numbers}
    ELSE
        Skip    This case only be tested in Taiwan website.
    END    
# ====================================================================================================



# ====================================================================================================
*** Keywords ***
My Profile Setup
    [Documentation]    Configuration before executing test steps in My Profile 1 suite.
    ${currentUrl}    Get Location
    IF    $checkMyProfile in $currentUrl
        Reload Page
        Wait Until Element Is Visible    ${btn_editProfile}
    ELSE
        IF    $checkTaiwan not in $url_usedUrl
            Log in to Wallet Codes website
        ELSE IF    $checkTaiwan in $url_usedUrl
            IF    $checkStaging not in $url_usedUrl
                Log in to Wallet Codes website    ${valid_email3}    ${valid_password3}    english=${False}
            ELSE
                Log in to Wallet Codes website    english=${False}
            END
        END
        Go to My Profile Page
    END

Go to My Profile Page
    [Documentation]    Redirect user to "My Profile" page under My Account menu. Make sure you're already
    ...                logged  before executing this keyword.
    Sleep    1s
    Mouse Over    ${drd_myAccountsTop}
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${opt_myAccounts}
    Wait Until Element Is Visible    ${btn_editProfile}

Verify Invalid Email in My Profile
    [Documentation]    Assertion for verifying whether system return error upon inputting invalid email
    ...                in email field or not.
    [Arguments]    @{emails}
    FOR    ${email}    IN    @{emails}
        Wait Until Keyword Succeeds    10s    1s    Press Keys    ${inp_emailMyProfile}    CTRL+A    DELETE
        Wait Until Keyword Succeeds    10s    1s    Input Text    ${inp_emailMyProfile}    ${email}
        Wait Until Keyword Succeeds    10s    1s    Press Keys    ${inp_passwordMyProfile}    CTRL+A    DELETE
        Wait Until Keyword Succeeds    10s    1s    Input Text    ${inp_passwordMyProfile}    ${valid_password}
        Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_submitSaveProfile}
        IF    $email == $invalid_email4 or $email== $invalid_email8
            Sleep    2s
            Run Keyword And Continue On Failure    Element Should Be Visible    ${err_invalidEmailMyProfile2}
            Run Keyword And Continue On Failure    Click Element    ${err_invalidEmailMyProfile2}
        ELSE
            Sleep    1s
            Run Keyword And Continue On Failure    Element Should Be Visible    ${err_invalidEmailMyProfile}
            Run Keyword And Continue On Failure    Element Should Be Visible    ${err_invalidFieldsMyProfile}
            Run Keyword And Continue On Failure    Click Element    ${err_invalidFieldsMyProfile}
        END
    END

Verify Invalid Password in My Profile
    [Documentation]    Assertion for verifying whether system return error upon inputting invalid password 
    ...                in password field or not.
    [Arguments]    @{passwords}
    FOR    ${password}    IN    @{passwords}
        Wait Until Element Is Enabled    ${inp_passwordMyProfile}
        Wait Until Keyword Succeeds    10s    1s    Press Keys    ${inp_passwordMyProfile}    CTRL+A    DELETE
        Wait Until Keyword Succeeds    10s    1s    Input Text    ${inp_passwordMyProfile}    ${password}
        Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_submitSaveProfile}
        Sleep    1s
        Run Keyword And Continue On Failure    Element Should Be Visible    ${err_emptyFieldsMyProfile}
        Wait Until Keyword Succeeds    10s    1s    Click Element    ${err_emptyFieldsMyProfile}
        Sleep    0.5s
        IF    $checkTaiwan not in $url_usedUrl
            Run Keyword And Continue On Failure    Element Should Be Visible    ${err_invalidPasswordMyProfile}
        ELSE IF    $checkTaiwan in $url_usedUrl
            Run Keyword And Continue On Failure    Element Should Be Visible    ${err_invalidPasswordMyProfileTW}
        END
    END

Verify Invalid Phone in Profile
    [Documentation]    Assertion to verify error message upon inputting invalid phone number in profile.
    [Arguments]    ${invalid_phones}
    Execution Settings    browser_implicit_wait=3
    FOR    ${invalid_phone}    IN    @{invalid_phones}
        Wait Until Keyword Succeeds    10s    1s    Press Keys    ${inp_phoneNumberRegister}    CTRL+A    DELETE
        Wait Until Keyword Succeeds    10s    1s    Input Text    ${inp_phoneNumberRegister}    ${invalid_phone}
        Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_submitSaveProfile}
        Sleep    1s
        # Run Keyword And Continue On Failure    Element Should Be Visible    ${err_invalidFieldsMyProfile}
        # Run Keyword And Continue On Failure    Click Element    ${err_emptyFieldsMyProfile}
        Run Keyword And Continue On Failure    Element Should Be Visible    ${err_invalidPasswordMyProfile}
    END
    Execution Settings    browser_implicit_wait=15
    
Click on Edit in My Profile
    [Documentation]    Trigger editable mode in profile.
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_editProfile}
    Wait Until Element Is Visible    ${inp_nameMyProfile}
    Sleep    1s

Cancel Edit on My Profile
    [Documentation]    Cancel any updates in profile.
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_cancelSaveProfile}
    Wait Until Element Is Visible    ${btn_editProfile}

Clear Fields in My Profile Non Taiwan
    [Documentation]    Clear name, email and password value in profile for Non-Taiwan website.
    Wait Until Keyword Succeeds    10s    1s    Clear Form Input    ${inp_nameMyProfile}
    Wait Until Keyword Succeeds    10s    1s    Clear Form Input    ${inp_emailMyProfile}
    Wait Until Keyword Succeeds    10s    1s    Clear Form Input    ${inp_passwordMyProfile}

Clear Fields in My Profile Taiwan
    [Documentation]    Clear name, email, password, phone number and DoB value in profile for Taiwan website.
    Wait Until Keyword Succeeds    10s    1s    Clear Form Input    ${inp_nameMyProfile}
    Wait Until Keyword Succeeds    10s    1s    Clear Form Input    ${inp_emailMyProfile}
    Wait Until Keyword Succeeds    10s    1s    Clear Form Input    ${inp_passwordMyProfile}
    Wait Until Keyword Succeeds    10s    1s    Clear Form Input    ${inp_phoneNumberRegister}
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${inp_DoBRegister}
    Wait Until Keyword Succeeds    10s    1s    Press Keys    ${inp_DoBRegister}    DELETE    TAB    DELETE    TAB    DELETE

Save My Profile
    [Documentation]    Click on save button in profile page.
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_submitSaveProfile}

Verify Empty Fields in My Profile Non Taiwan
    [Documentation]    Assertion to verify whether fields under my profile page is empty or not. It's for Non-
    ...                Taiwan website.
    Sleep    2s
    Run Keyword And Continue On Failure    Element Should Be Visible    ${err_emptyFieldsMyProfile}
    Run Keyword And Continue On Failure    Element Should Be Visible    ${err_emptyNameFieldMyProfile}
    Run Keyword And Continue On Failure    Element Should Be Visible    ${err_emptyEmailFieldMyProfile}

Verify Empty Fields in My Profile Taiwan
    [Documentation]    Assertion to verify whether fields under my profile page is empty or not. It's for
    ...                Taiwan website.
    Sleep    2s
    Run Keyword And Continue On Failure    Element Should Be Visible    ${err_emptyFieldsMyProfile}
    Run Keyword And Continue On Failure    Element Should Be Visible    ${err_emptyNameFieldMyProfile}
    Run Keyword And Continue On Failure    Element Should Be Visible    ${err_emptyEmailFieldMyProfile}
    Run Keyword And Continue On Failure    Element Should Be Visible    ${err_emptyPhoneNumberRegister}

Verify If Nothing's Changed After Cancelling
    [Documentation]    Assertion to verify whether profile's info should not changed after cancel to edit profile.
    IF    $checkTaiwan not in $url_usedUrl
        Run Keyword And Continue On Failure    Element Should Contain    ${txt_nameMyProfile}    ${valid_name}
        Run Keyword And Continue On Failure    Element Should Contain    ${txt_emailMyProfile}    ${valid_email2}
    ELSE IF    $checkTaiwan in $url_usedUrl
        IF    $checkStaging in $url_usedUrl
            Run Keyword And Continue On Failure    Element Should Contain    ${txt_nameMyProfile}    ${valid_name}
            Run Keyword And Continue On Failure    Element Should Contain    ${txt_emailMyProfile}    ${valid_email2}
        ELSE
            Run Keyword And Continue On Failure    Element Should Contain    ${txt_nameMyProfile}    ${valid_name4}
            Run Keyword And Continue On Failure    Element Should Contain    ${txt_emailMyProfile}    ${valid_email3}
        END
        
    END

Add Invalid Emails
    [Documentation]    Return list of invalid emails.
    ${invalid_emails}    Create List    ${invalid_email1}    ${invalid_email2}    ${invalid_email3}    
    ...    ${invalid_email4}    ${invalid_email6}    ${invalid_email7}    ${invalid_email8}
    RETURN    ${invalid_emails}

Add Invalid Passwords
    [Documentation]    Return list of invalid passwords.
    @{invalid_passwords}    Create List    ${invalid_password1}    ${invalid_password2}    
    ...    ${invalid_password3}    ${invalid_password4}    ${invalid_password5}    ${invalid_password6}
    RETURN    ${invalid_passwords}

Add Invalid Phone Numbers
    [Documentation]    Return list of invalid phone numbers.
    @{phones}    Create List    ${invalid_phone1}    ${invalid_phone2}    ${invalid_phone3}
        ...    ${invalid_phone4}
    RETURN    ${phones}
# ====================================================================================================