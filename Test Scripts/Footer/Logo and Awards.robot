# ====================================================================================================
*** Settings ***
Documentation    Logo and Awards Section in Footer Test Suite.
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
C9977 Wallet Codes logo in footer redirection
    [Documentation]    Logo functionality in footer.
    [Tags]    Staging    Preprod    Production    Global    Taiwan
    # Not in Homepage
    IF    $checkTaiwan not in $url_usedUrl
        Change Language to English
        Go to Steam ID Page
        Verify Footer Logo Not In Homepage
    ELSE IF     $checkTaiwan in $url_usedUrl
        Go to Garena TW Page
        Verify Footer Logo Not In Homepage
        Close Modal Pop-up
    END
    
    # In Homepage
    Verify Footer Logo In Homepage

C9990 Awards and Now Available
    [Documentation]    Awards section and google play now available image redirection in footer.
    [Tags]    Staging    Preprod    Production    Global    Taiwan
    # APSA
    Verify Awards - APSA
    ${tabs}    Get Browser Tabs
    Go Back to Wallet Codes Website    ${tabs}

    # ACA
    Verify Awards - ACA
    Go Back to Wallet Codes Website    ${tabs}

    # Playstore
    Verify Google Playstore CTA
# ====================================================================================================



# ====================================================================================================
*** Keywords ***
Verify Footer Logo Not In Homepage
    [Documentation]    Assertion for verifying whether user is redirected to Homepage or not upon clicking 
    ...                logo in footer. Initial position of user is not in homepage.
    Scroll Element Into View    ${img_logoFooter}
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${img_logoFooter}
    Page Should Contain Element    ${unq_bannerActive}

Verify Footer Logo In Homepage
    [Documentation]    Assertion for verifying whether user is redirected to Homepage or not upon clicking 
    ...                logo in footer. Initial position of user is in homepage.
    Scroll Element Into View    ${img_logoFooter}
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${img_logoFooter}
    ${scrollPosition}    Execute Javascript    return window.document.body.scrollTop
    Should Be Equal As Integers    ${scrollPosition}    0
    
Verify Awards - APSA
    [Documentation]    Assertion to verify whether user is redirected to APSA Awards or not.
    Scroll Element Into View    ${img_logoFooter}
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_awardsAPSA}
    ${currentUrls}    Get Locations
    Should Be Equal    ${url_apsaAward}    ${currentUrls}[-1]

Verify Awards - ACA
    [Documentation]    Assertion to verify whether user is redirected to ACA Awards or not.
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_awardsACA}
    ${currentUrls}    Get Locations
    Should Be Equal    ${url_acaAward}    ${currentUrls}[-1]

Verify Google Playstore CTA
    [Documentation]    Assertion to verify whether user is redirected to Google Playstore or not.
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_playStore}
    ${currentUrls}    Get Locations
    Should Be Equal    ${url_playstorePage}    ${currentUrls}[-1]
    
Get Browser Tabs
    [Documentation]    Return address of all opened tab in current browser.
    ${handles}    Get Window Handles
    RETURN    ${handles}

Go Back to Wallet Codes Website
    [Documentation]    Redirect user to wallet codes website if user is not in wallet codes.
    [Arguments]    ${handles}
    Switch Window    ${handles}[0]
# ====================================================================================================