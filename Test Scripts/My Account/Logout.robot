# ====================================================================================================
*** Settings ***
Documentation    Log out functionalities.
...              
...              Test Environment: *${global_env}*
Resource    ../../Resources/imports.resource
Test Tags    Regression
Test Setup    Go to Wallet Codes Website    ${global_env}    chrome
Test Teardown    End Testing
# ====================================================================================================



# ====================================================================================================
*** Variables ***
# ====================================================================================================



# ====================================================================================================
*** Test Cases ***
C10005 Log out successfully
    [Documentation]    Logout functionality.
    [Tags]    Staging    Preprod    Production    Global    Taiwan
    Log in to Website for All Country
    Log out from Website
    Verify User Has Been Logged Out  
# ====================================================================================================



# ====================================================================================================
*** Keywords ***
Log in to Website for All Country
    [Documentation]    Try log in for Taiwan and Non-Taiwan website.
    IF    $checkTaiwan not in $url_usedUrl
        Log in to Wallet Codes website
    ELSE IF    $checkTaiwan in $url_usedUrl
        Log in to Wallet Codes website    english=${False}
    END

Log out from Website
    [Documentation]    Log out from current user.
    Wait Until Keyword Succeeds    10s    1s    Mouse Over    ${drd_myAccountsTop}
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${opt_logout}

Verify User Has Been Logged Out
    [Documentation]    Assertion to check whether user has been logged out or not.
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
# ====================================================================================================