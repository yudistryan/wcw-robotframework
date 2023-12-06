# ====================================================================================================
*** Settings ***
Documentation    Daily Rewards functionalities.
...              
...              Test Environment: *${global_env}*
Resource    ../../Resources/imports.resource
Test Tags    Regression
Suite Setup    Go to Wallet Codes Website    ${global_env}    chrome    10
Suite Teardown    End Testing
# ====================================================================================================



# ====================================================================================================
*** Variables ***
${dailyRewardsPage}    /user-profile/daily-rewards
# ====================================================================================================



# ====================================================================================================
*** Test Cases ***
# C10611 Claim daily reward successfully
# C10612 Claim under registered country
# C10637 Claim under unregistered country
# C10638 Claim again after successfully claimed
C11229 What is the benefit redirects to support page
    [Documentation]    Redirection of 'What is Benefit?' CTA in Daily Rewards Page
    [Tags]    Staging    Preprod    Production    Global
    Skip If This is Taiwan Website
    Daily Rewards Suite Setup
    Go to Daily Rewards
    Click on What is the benefit CTA
    Verify User is Redirected to P Points Support Page
# ====================================================================================================



# ====================================================================================================
*** Keywords ***
Daily Rewards Suite Setup
    [Documentation]    Configuration before executing test steps in Daily Rewards suite.
    Check If This is Taiwan Website
    ${currentUrl}    Get Location
    IF    $dailyRewardsPage in $currentUrl
        Reload Page
        Wait Until Element Is Visible    ${unq_dailyRewardPage}
    ELSE
        Go to Daily Rewards
    END

Go to Daily Rewards
    [Documentation]    Redirect user to Daily Rewards page.
    ${logged_in}    Check Log In
    IF    not $logged_in
        Log in to Wallet Codes website    english=${False}
        Sleep    0.75s
        IF    $checkTaiwan not in $url_usedUrl
            Wait Until Keyword Succeeds    10s    1s    Mouse Over    ${drd_myPPointsTop}
        ELSE IF    $checkTaiwan in $url_usedUrl 
            Wait Until Keyword Succeeds    10s    1s    Mouse Over    ${drd_myPointsTop}
        END
        Wait Until Keyword Succeeds    10s    1s    Click Element    ${opt_dailyRewards}
        Wait Until Element Is Visible    ${unq_dailyRewardPage}
    ELSE
        IF    $checkTaiwan not in $url_usedUrl
            Wait Until Keyword Succeeds    10s    1s    Mouse Over    ${drd_myPPointsTop}
        ELSE IF    $checkTaiwan in $url_usedUrl 
            Wait Until Keyword Succeeds    10s    1s    Mouse Over    ${drd_myPointsTop}
        END
        Wait Until Keyword Succeeds    10s    1s    Click Element    ${opt_dailyRewards}
        Wait Until Element Is Visible    ${unq_dailyRewardPage}
    END

Click on What is the benefit CTA
    [Documentation]    Redirect user to Daily Rewards support page.
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_whatIsTheBenefit}

Verify User is Redirected to P Points Support Page
    [Documentation]    Assertion to verify whether user is redirected to P Point support page or not.
    Wait Until Element Is Visible    ${unq_ppointsDefinitions}    10s
# ====================================================================================================
