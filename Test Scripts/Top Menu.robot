# ====================================================================================================
*** Settings ***
Documentation    Top Menu functionalities
...              
...              Test Environment: *${global_env}*
Resource    ../Resources/imports.resource
Test Tags    Regression
Suite Setup    Go to Wallet Codes Website    ${global_env}    chrome
Suite Teardown    End Testing
# ====================================================================================================


# ====================================================================================================
*** Variables ***
# ====================================================================================================



# ====================================================================================================
*** Test Cases ***
C9962 Contact us menu redirection
    [Documentation]    Contact us CTA in Top Menu functionality.
    [Tags]    Staging    Preprod    Production    Global    Taiwan
    Go to Contact Us Page
    Go To WC4B/Bulk Purchase

C9964 Blog menu redirection
    [Documentation]    Blog CTA in Top Menu functionality.
    [Tags]    Staging    Preprod    Production    Global    Taiwan
    Go To Blog

C9969 Language translation
    [Documentation]    Language options CTA in Top Menu functionality.
    [Tags]    Staging    Preprod    Production    Global    Taiwan    Retest
    Check If This is Taiwan Website
    Verify Register and Login Button
    Click on Local Language
    Verify Register and Login for Local Language

C9965 Register menu redirection
    [Documentation]    Register CTA in Top Menu functionality.
    [Tags]    Staging    Preprod    Production    Global    Taiwan
    Check If This is Taiwan Website
    Verify Register Redirection
    
C9966 Login menu redirection
    [Documentation]    Login CTA in Top Menu functionality.
    [Tags]    Staging    Preprod    Production    Global    Taiwan
    Check If This is Taiwan Website
    Verify Login Redirection

C9963 Products menu redirection
    [Documentation]    Products CTA in Top Menu functionality.
    [Tags]    Staging    Preprod    Production    Global    Taiwan
    Check If This is Taiwan Website
    Mouse Over Product Menu
    IF    $checkTaiwan not in $url_usedUrl
        Click on Steam Product
        Verify on Steam Product
        Click on Roblox Product
        IF    $checkStaging in $url_usedUrl
            Verify on Roblox Product in Staging
            Click on PSN ID in Staging
            Verify on PSN ID in Staging
            Click on Saint Seiya ID in Staging
            Verify on Saint Seiya ID in Staging
        ELSE
            Verify on Roblox Product in Preprod and Production
            Click on PSN ID in Preprod and Production
            Verify on PSN ID in Preprod and Production
            Click on Saint Seiya ID in Preprod and Production
            Verify on Saint Seiya ID in Preprod and Production
        END
    ELSE IF    $checkTaiwan in $url_usedUrl
        Click on Mobile Legends TW
        Verify on Mobile Legends TW
        Click on Roblox TW
        Verify on Roblox TW
        Click on Garena Shell TW
        Verify on Garena Shell TW
    END

C9967 My p points menu redirection
    [Documentation]    My P Points CTA in Top Menu functionality.
    [Tags]    Staging    Preprod    Production    Global    Taiwan
    IF    $checkTaiwan not in $url_usedUrl
        Check If This is Taiwan Website
        Log In Setup
        Go to P Points' Redeem and History
        Verify Points Elements in My Points page
        Go to P Points' Daily Reward
        Verify Daily Rewards Page
    ELSE IF    $checkTaiwan in $url_usedUrl
        IF    $checkStaging not in $url_usedUrl and $checkPreprod not in $url_usedUrl
            Log In Setup    ${valid_email3}    ${valid_password3}
            Go to P Points' Redeem and History
            Verify Points Elements in My Points page
            Go to P Points' Daily Reward
            Verify Daily Rewards Page
        ELSE
            Log In Setup    ${valid_email3}    ${valid_password3}
            Go to Points' Redeem and History
            Verify Points Elements in My Points page
            Go to Points' Daily Reward
            Verify Daily Rewards Page
        END
    END

C9968 My account menu redirection
    [Documentation]    My Account CTA in Top Menu functionality.
    [Tags]    Staging    Preprod    Production    Global    Taiwan
    Log In Setup
    Check If This is Taiwan Website
    # Check fo unexpected error
    Mouse Over My Accounts Menu
    Click on My Account Submenu
    Verify My Profile Page
    Mouse Over My Accounts Menu
    Click on Transaction History
    Verify on Transaction History
    Mouse Over My Accounts Menu
    Click on Logout
    Verify upon Logging Out
# ====================================================================================================



# ====================================================================================================
*** Keywords ***
Log In Setup
    [Documentation]    Check if user is already logged in or not. If not, will try to log in.
    ...                Email and password by defaults are for yudis.yufanria+test@wallet-codes.com. 
    ...                You put you own email and password by inputting the $email and $password parameters. 
    ...                If $english parameter is True then it will change the language into English before 
    ...                proceed to login.
    [Arguments]    ${email}=${valid_email2}    ${password}=${valid_password}    ${english}=${False}
    ${before}    Get Selenium Implicit Wait
    Set Selenium Implicit Wait    1s
    ${logged_in}    Run Keyword And Return Status    Element Should Be Visible    ${drd_myAccountsTop}
    Set Selenium Implicit Wait    ${before}
    IF    $logged_in
        Reload Page
    ELSE
        IF    $checkTaiwan not in $url_usedUrl
            Log in to Wallet Codes website    ${email}    ${password}
        ELSE IF    $checkTaiwan in $url_usedUrl
            Log in to Wallet Codes website    ${email}    ${password}    ${english}
        END
    END

Go To Contact Us Page
    [Documentation]    Go to Contact Us form page.
    Mouse Over    ${drd_contactUsTop}
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${opt_contactUs}
    Run Keyword And Continue On Failure    Element Should Be Visible    ${unq_contactUs}

Go To WC4B/Bulk Purchase
    [Documentation]    Redirect user to WC4B/Bulk Purchase page.
    Mouse Over    ${drd_contactUsTop}
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${opt_wcB2B}
    ${currentUrl}    Get Locations
    Should Be Equal    ${url_wc4b}    ${currentUrl}[-1]
    Switch Window    url:${currentUrl}[0]

Go To Blog
    [Documentation]    Redirect user to Blog page.
    Wait Until Keyword Succeeds    10s    1s    Click Element   ${btn_blogTop}
    ${currentUrl}    Get Locations
    Should Be Equal    ${url_blog}    ${currentUrl}[-1]
    Switch Window    url:${currentUrl}[0]

Click on Local Language
    [Documentation]    After language options is shown, click any local language. Only valid for Iindonesia
    ...                and Taiwan.
    Wait Until Keyword Succeeds    10s    1s    Mouse Over    ${drd_language}
    IF    $checkTaiwan not in $url_usedUrl
        Wait Until Keyword Succeeds    10s    1s    Click Element    ${opt_idLanguage}
    ELSE IF    $checkTaiwan in $url_usedUrl
        Wait Until Keyword Succeeds    10s    1s    Click Element    ${opt_chinese}
    END

Mouse Over Product Menu
    [Documentation]    Hover over product menu on top.
    Wait Until Keyword Succeeds    10s    1s    Mouse Over    ${drd_productsTop}

Click on Steam Product
    [Documentation]    Click on Steam Wallet product option in Indonesia website.
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${opt_steamProduct}

Verify on Steam Product
    [Documentation]    Assertion for Steam Wallet product whether it's visible or not.
    Run Keyword And Continue On Failure    Element Should Be Visible    ${unq_steamIDPage}

Click on Roblox Product
    [Documentation]    Click on Roblox product option in Indonesia website.
    Mouse Over    ${drd_productsTop}
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${opt_robloxProduct}

Verify on Roblox Product in Staging
    [Documentation]    Assertion for Indonesia Steam Wallet product whether it's visible or not in Staging.
    Run Keyword And Continue On Failure    Element Should Be Visible    ${unq_robloxIDPage}

Verify on Roblox Product in Preprod and Production
    [Documentation]    Assertion for Indonesia Steam Wallet product whether it's visible or not in 
    ...                Pre-Production and Production.
    Run Keyword And Continue On Failure    Element Should Be Visible    ${unq_robloxIDPage2}

Click on PSN ID in Staging
    [Documentation]    Click on Indonesia Playstation Network product option in Staging website.
    Wait Until Keyword Succeeds    10s    1s    Mouse Over    ${drd_productsTop}
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${opt_psnIDProduct}

Verify on PSN ID in Staging
    [Documentation]    Assertion for Indonesia Playstation Network product whether it's visible or not in Staging.
    Run Keyword And Continue On Failure    Element Should Be Visible    ${unq_psnIDPage}

Click on PSN ID in Preprod and Production
    [Documentation]    Click on Indonesia Playstation Network product option in Pre-Production and 
    ...                Production website.
    Wait Until Keyword Succeeds    10s    1s    Mouse Over    ${drd_productsTop}
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${opt_psnIDProduct2}

Verify on PSN ID in Preprod and Production
    [Documentation]    Assertion for Indonesia Playstation Network product whether it's visible or not in 
    ...                Pre-Production and Production.
    Run Keyword And Continue On Failure    Element Should Be Visible    ${unq_psnIDPage2}

Click on Saint Seiya ID in Staging
    [Documentation]    Click on Indonesia Saint Seiya product option in Staging website.
    Wait Until Keyword Succeeds    10s    1s    Mouse Over    ${drd_productsTop}
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${opt_saintseiyaIDProduct}

Verify on Saint Seiya ID in Staging
    [Documentation]    Assertion for Indonesia Saint Seiya product whether it's visible or not in Staging.
    Run Keyword And Continue On Failure    Element Should Be Visible    ${unq_saintSeiyaIDpage}

Click on Saint Seiya ID in Preprod and Production
    [Documentation]    Click on Indonesia Saint Seiya product option in Pre-Production and Production
    ...                website.
    Wait Until Keyword Succeeds    10s    1s    Mouse Over    ${drd_productsTop}
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${opt_saintseiyaIDProduct2}

Verify on Saint Seiya ID in Preprod and Production
    [Documentation]    Assertion for Indonesia Saint Seiya product whether it's visible or not in 
    ...                Pre-Production and Production.
    Run Keyword And Continue On Failure    Element Should Be Visible    ${unq_saintSeiyaIDpage3}

Click on Mobile Legends TW
    [Documentation]    Click on Mobile Legends product option in Taiwan website.
    Wait Until Keyword Succeeds    10s    1s    Mouse Over    ${drd_productsTop}
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${opt_mobileLegendsTW}

Verify on Mobile Legends TW
    [Documentation]    Assertion for Mobile Legends product whether it's visible or not.
    Run Keyword And Continue On Failure    Element Should Be Visible    ${unq_mobileLegendsTW2}

Click on Roblox TW
    [Documentation]    Click on Roblox product option in Taiwan website.
    Wait Until Keyword Succeeds    10s    1s    Mouse Over    ${drd_productsTop}
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${opt_robloxTWProduct}

Verify on Roblox TW
    [Documentation]    Assertion for Roblox product whether it's visible or not.
    Run Keyword And Continue On Failure    Element Should Be Visible    ${unq_robloxIDPageTW}

Click on Garena Shell TW
    [Documentation]    Click on Garena Shell product option in Taiwan website.
    Wait Until Keyword Succeeds    10s    1s    Mouse Over    ${drd_productsTop}
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${opt_garenaTWProduct}

Verify on Garena Shell TW
    [Documentation]    Assertion for Garena Shell product whether it's visible or not.
    Run Keyword And Continue On Failure    Element Should Be Visible    ${unq_garenaShellsTW2}

Go to P Points' Redeem and History
    [Documentation]    Go to P Points Redeem and History page.
    Mouse Over    ${drd_mypPointsTop}
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${opt_redeemHistory}

Go to Points' Redeem and History
    [Documentation]    Go to Points Redeem and History page. It's for Taiwan Staging.
    Wait Until Keyword Succeeds    10s    1s    Mouse Over    ${drd_myPointsTop}
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${opt_redeemHistory}

Go to P Points' Daily Reward
    [Documentation]    Go to P Points Daily Reward page.
    Wait Until Keyword Succeeds    10s    1s    Mouse Over    ${drd_myPPointsTop}
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${opt_dailyRewards}

Go to Points' Daily Reward
    [Documentation]    Go to P Points Daily Reward page. It's for Taiwan Staging.
    Wait Until Keyword Succeeds    10s    1s    Mouse Over    ${drd_myPointsTop}
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${opt_dailyRewards}

Verify Daily Rewards Page
    [Documentation]    Assertion for daily rewards page whether user is redirected there or not.
    Run Keyword And Continue On Failure    Element Should Be Visible    ${unq_dailyRewardPage}

Mouse Over My Accounts Menu
    [Documentation]    Hover over My Accounts Menu. User must be logged in first.
    Check For Unexpected Error
    Mouse Over    ${drd_myAccountsTop}

Click on My Account Submenu
    [Documentation]    Click on My Accounts/My Profile under My Account menu. User must be logged in first.
    Wait Until Element Is Visible    ${opt_myAccounts}
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${opt_myAccounts}

Verify My Profile Page
    [Documentation]    Assertion whether user is redirected to my profile page or not.
    Run Keyword And Continue On Failure    Element Should Be Visible    ${unq_myProfilePage}

Click on Transaction History
    [Documentation]    Click on Transaction History under My Account menu. User must be logged in first.
    Wait Until Element Is Visible    ${opt_transactionHistory}
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${opt_transactionHistory}

Verify on Transaction History
    [Documentation]    Assertion whether user is redirected to transaction history page or not.
    Run Keyword And Continue On Failure    Element Should Be Visible    ${unq_transactionHistoryPage}

Click on Logout
    [Documentation]    Click on Logout CTA. User must be logged in first.
    Wait Until Element Is Visible    ${opt_logout}
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${opt_logout}

Verify upon Logging Out
    [Documentation]    Assertion whether user is actually logged out or not.
    IF    $checkStaging in $url_usedUrl or $checkPreprod in $url_usedUrl
        Run Keyword And Continue On Failure    Element Should Be Visible    ${btn_loginTop}
    ELSE IF    $checkStaging not in $url_usedUrl and $checkPreprod not in $url_usedUrl
        IF    $checkTaiwan not in $url_usedUrl
            Run Keyword And Continue On Failure    Element Should Be Visible    ${btn_loginTop2}
        ELSE IF    $checkTaiwan in $url_usedUrl
            Run Keyword And Continue On Failure    Element Should Be Visible    ${btn_loginTop}
        END
    END

Verify Register and Login Button
    [Documentation]    Assertion whether Register and Login button is visible or not.
    Sleep    0.5s
    IF    $checkStaging in $url_usedUrl or $checkPreprod in $url_usedUrl
        Wait Until Element Is Visible    ${btn_registerTop}
        Wait Until Element Is Visible    ${btn_loginTop}
    ELSE IF    $checkStaging not in $url_usedUrl and $checkPreprod not in $url_usedUrl
        IF    $checkTaiwan not in $url_usedUrl
            Wait Until Element Is Visible    ${btn_registerTop2}
            Wait Until Element Is Visible    ${btn_loginTop2}
        ELSE IF    $checkTaiwan in $url_usedUrl
            Wait Until Element Is Visible    ${btn_registerTop}
            Wait Until Element Is Visible    ${btn_loginTop}
        END
    END

Verify Register and Login for Local Language
    [Documentation]    Assertion whether Register and Login button is visible or not for local language.
    ...                For now only valid for Indonesia and Taiwan website.
    Sleep    1s
    IF    $checkStaging in $url_usedUrl or $checkPreprod in $url_usedUrl
        Run Keyword And Continue On Failure    Element Should Not Be Visible    ${btn_registerTop}
        Run Keyword And Continue On Failure    Element Should Not Be Visible    ${btn_loginTop}
        IF    $checkTaiwan in $url_usedUrl
            Change Language to English
        END
    ELSE IF    $checkStaging not in $url_usedUrl and $checkPreprod not in $url_usedUrl
        IF    $checkTaiwan not in $url_usedUrl
            Run Keyword And Continue On Failure    Element Should Not Be Visible    ${btn_registerTop2}
            Run Keyword And Continue On Failure    Element Should Not Be Visible    ${btn_loginTop2}
        ELSE IF    $checkTaiwan in $url_usedUrl
            Close Modal Pop-up
            Run Keyword And Continue On Failure    Element Should Be Visible    ${btn_registerTopTW}
            Run Keyword And Continue On Failure    Element Should Be Visible    ${btn_loginTopTW}
            Change Language to English
        END
    END

Verify Register Redirection
    [Documentation]    Assertion whether user is redirected to Register page or not.
    Sleep    0.5s
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
    
Verify Login Redirection
    [Documentation]    Assertion whether user is redirected to Login page or not.
    Sleep    0.5s
    IF    $checkStaging in $url_usedUrl or $checkPreprod in $url_usedUrl
        Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_loginTop}
        IF    $checkTaiwan not in $url_usedUrl
            Wait Until Element Is Visible    ${unq_loginPage}
        ELSE
            Wait Until Element Is Visible    ${unq_loginPage2}
        END
    ELSE IF    $checkStaging not in $url_usedUrl and $checkPreprod not in $url_usedUrl
        IF    $checkTaiwan not in $url_usedUrl
            Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_loginTop2}
            Wait Until Element Is Visible    ${unq_loginPage2}
        ELSE IF     $checkTaiwan in $url_usedUrl
            Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_loginTop}
            Wait Until Element Is Visible    ${unq_loginPage}
        END
    END

Verify Points Elements in My Points page
    [Documentation]    Assertion for P Points page's elements whether it's visible or not.
    @{elements}    Create List    ${unq_redeemPPointPage}    ${unq_titlePPointPage}    
        ...    ${unq_pPointHistoryTitle}    ${unq_crumbPPointHistory}    ${txt_pPointUnderPromoCode}
    FOR    ${element}    IN    @{elements}
        Run Keyword And Continue On Failure    Element Should Be Visible    ${element}
    END
# ====================================================================================================