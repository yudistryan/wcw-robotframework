# ====================================================================================================
*** Settings ***
Documentation    My Profile scripts for positive test cases.
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
C10006 Edit profile successfully
    [Documentation]    Saving with valid data upon editing my profile for Non-Taiwan website.
    [Tags]    Staging    Preprod    Production    Global
    IF    $checkTaiwan not in $url_usedUrl
        My Profile Setup for Positive Case
        Edit and Save Profile for Non-Taiwan
        Verify Successfully Save Profile
        Verify Profile New Info
        Reset Account Name and Email in My Profile
    ELSE IF    $checkTaiwan in $url_usedUrl
        Skip    This test case is not available for Taiwan website.
    END

C10020 Edit password
    [Documentation]    Saving with valid password upon editing my profile for all website.
    [Tags]    Staging    Preprod    Production    Global    Taiwan
    My Profile Setup for Positive Case
    Click on Edit in My Profile
    Update Password    ${valid_password2}
    Verify Successfully Save Profile
    Logout
    Relogin After Reset Password
    Go to My Profile Page
    Reset Password in My Profile

C11372 Edit phone number
    [Documentation]    Saving with valid phone number upon editing my profile for Taiwan website.
    [Tags]    Staging    Preprod    Production    Taiwan
    IF    $checkTaiwan in $url_usedUrl
        My Profile Setup for Positive Case
        Edit Phone number
        Verify User is Redirected to Phone Number Verification Page
    ELSE IF    $checkTaiwan not in $url_usedUrl
        Skip    This test case is not available for Non-Taiwan website.
    END
# ====================================================================================================



# ====================================================================================================
*** Keywords ***
My Profile Setup for Positive Case
    [Documentation]    Configuration before executing test steps in My Profile 2 suite.
    ${currentUrl}    Get Location
    IF    $checkMyProfile in $currentUrl
        Reload Page
        Wait Until Element Is Visible    ${btn_editProfile}
    ELSE
        IF    $checkTaiwan not in $url_usedUrl
            Log in to Wallet Codes website
        ELSE IF    $checkTaiwan in $url_usedUrl
            Log in to Wallet Codes website    ${valid_email5}    ${valid_password}    english=${False}
        END
        Go to My Profile Page
    END
    

Go to My Profile Page
    [Documentation]    Redirect user to "My Profile" page under My Account menu. Make sure you're already
    ...                logged in before executing this keyword.
    Sleep    1s
    Wait Until Keyword Succeeds    10s    1s    Mouse Over    ${drd_myAccountsTop}
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${opt_myAccounts}
    Wait Until Element Is Visible    ${btn_editProfile}    10s

Reset Account Name and Email in My Profile
    [Documentation]    Resetting email and name as per valid data in Test Data file.
    Wait Until Element Is Visible    ${unq_myProfilePage}
    Wait Until Element Is Visible    ${btn_editProfile}
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_editProfile}
    Wait Until Element Is Visible    ${inp_nameMyProfile}
    Sleep    1s
    Wait Until Keyword Succeeds    10s    1s    Input Text    ${inp_nameMyProfile}    ${valid_name}
    Wait Until Keyword Succeeds    10s    1s    Input Text    ${inp_emailMyProfile}    ${valid_email2}
    Sleep    0.5s
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_submitSaveProfile}
    Verify Successfully Save Profile
    Element Should Contain    ${txt_nameMyProfile}    ${valid_name}
    Element Should Contain    ${txt_emailMyProfile}    ${valid_email2}

Reset Password in My Profile
    [Documentation]    Resetting password as per valid data in Test Data file.
    Wait Until Element Is Visible    ${unq_myProfilePage}
    Wait Until Element Is Visible    ${btn_editProfile}
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_editProfile}
    Wait Until Element Is Visible    ${inp_nameMyProfile}
    Sleep    2s
    Press Keys    ${inp_passwordMyProfile}    CTRL+A    Delete
    Input Text    ${inp_passwordMyProfile}    ${valid_password}
    Sleep    0.5s
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_submitSaveProfile}
    Verify Successfully Save Profile

Logout
    [Documentation]    Logout from current session. Make sure you're already logged in before executing
    ...                this keyword.
    Mouse Over    ${drd_myAccountsTop}
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${opt_logout}
    IF    $checkStaging not in $url_usedUrl and $checkPreprod not in $url_usedUrl
        IF    $checkTaiwan in $url_usedUrl
            Close Modal Pop-up 
        END
    END
    IF    $checkStaging in $url_usedUrl or $checkPreprod in $url_usedUrl
        Element Should Be Visible    ${btn_registerTop}
        Element Should Be Visible    ${btn_loginTop}
    ELSE IF    $checkStaging not in $url_usedUrl and $checkPreprod not in $url_usedUrl
        IF    $checkTaiwan not in $url_usedUrl
            Element Should Be Visible    ${btn_registerTop2}
            Element Should Be Visible    ${btn_loginTop2}
        ELSE IF    $checkTaiwan in $url_usedUrl
            Element Should Be Visible    ${btn_registerTop}
            Element Should Be Visible    ${btn_loginTop}
        END
        
    END

Edit and Save Profile for Non-Taiwan
    [Documentation]    Update profile's information in Non-Taiwan website with valid data and save it.
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_editProfile}
    Wait Until Keyword Succeeds    10s    1s    Input Text    ${inp_nameMyProfile}    ${valid_name2}
    Wait Until Keyword Succeeds    10s    1s    Input Text    ${inp_emailMyProfile}    ${valid_email2}
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_submitSaveProfile}

Edit Phone number
    [Documentation]    Update profile's phone number with valid data and save it.
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_editProfile}
    Wait Until Element Is Enabled    ${inp_phoneNumberMyProfile}    10s
    Sleep    1s
    Wait Until Keyword Succeeds    10s    1s    Input Text    ${inp_phoneNumberMyProfile}    ${valid_phoneNumber3}
    Sleep    1s
    Wait Until Keyword Succeeds    10s    1s    Press Keys    ${inp_passwordMyProfile}    CTRL+A    Delete
    Wait Until Keyword Succeeds    10s    1s    Input Text    ${inp_passwordMyProfile}    ${valid_password}
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_submitSaveProfile}

Verify User is Redirected to Phone Number Verification Page
    [Documentation]    Assertion to verify whether user is redirected to phone number verification page.
    Wait Until Element Is Visible    ${unq_EnterOTP}    5s

Verify Successfully Save Profile
    [Documentation]    Assertion to verify whether profile is saved successfully or not.
    IF    $checkTaiwan not in $url_usedUrl
        IF    $checkStaging in $url_usedUrl or $checkPreprod in $url_usedUrl
            Wait Until Element Is Visible    ${unq_successSaveProfile}    5s
            Run Keyword And Continue On Failure    Click Element    ${unq_successSaveProfile}
        ELSE IF    $checkStaging not in $url_usedUrl and $checkPreprod not in $url_usedUrl
            Wait Until Element Is Visible    ${unq_successSaveProfile2}    5s
            Run Keyword And Continue On Failure    Click Element    ${unq_successSaveProfile2}
        END
    ELSE IF    $checkTaiwan in $url_usedUrl
        Wait Until Element Is Visible    ${unq_successSaveProfile2}    5s
        Run Keyword And Continue On Failure    Click Element    ${unq_successSaveProfile2}
    END

Verify Profile New Info
    [Documentation]    Assertion to verify whether current profile is updated or not.
    Element Should Contain    ${txt_nameMyProfile}    ${valid_name2}
    Element Should Contain    ${txt_emailMyProfile}    ${valid_email2}

Click on Edit in My Profile
    [Documentation]    Trigger editable mode in the profile page.
    Wait Until Element Is Visible    ${btn_editProfile}
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_editProfile}
    Wait Until Element Is Visible    ${inp_nameMyProfile}
    Sleep    1s

Update Password
    [Documentation]    Modify old password into desired new password.
    [Arguments]    ${new_password}
    Clear Form Input    ${inp_passwordMyProfile}
    Wait Until Keyword Succeeds    10s    1s    Input Text    ${inp_passwordMyProfile}    ${new_password}
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_submitSaveProfile}

Relogin After Reset Password
    [Documentation]    Try to log in again after reset password.
    IF    $checkTaiwan not in $url_usedUrl
        Log in to Wallet Codes website    password=${valid_password2}    english=${False}
    ELSE IF    $checkTaiwan in $url_usedUrl
        Log in to Wallet Codes website    email=${valid_email5}    password=${valid_password2}    english=${False}
    END
# ====================================================================================================