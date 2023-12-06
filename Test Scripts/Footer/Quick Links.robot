# ====================================================================================================
*** Settings ***
Documentation    Quick Links Section in Footer Test Suite.
...              
...              Test Environment: *${global_env}*.
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
C9982 Quick links - Home button
    [Documentation]    Home button redirection in footer.
    [Tags]    Staging    Preprod    Production    Global    Taiwan
    # Not in Homepage
    IF    $checkTaiwan not in $url_usedUrl
        Change Language to English
        Go to Steam ID Page
        Verify Footer Logo Not In Homepage
    ELSE IF    $checkTaiwan in $url_usedUrl
        Go to Garena TW Page
        Verify Footer Logo Not In Homepage
    END

    # In Homepage
    Verify Footer Logo In Homepage

C9983 Quick links - Why wallet codes button
    [Documentation]    Why wallet codes redirection in footer.
    [Tags]    Staging    Preprod    Production    Global    Taiwan
    Check If This is Taiwan Website
    Verify Why Wallet Codes CTA

C9984 Quick links - Blog button
    [Documentation]    Blog redirection redirection in footer.
    [Tags]    Staging    Preprod    Production    Global    Taiwan
    Verify Blog CTA

C9985 Quick links - WC B2B button
    [Documentation]    WC B2B/Bulk Purchase redirection in footer.
    [Tags]    Staging    Preprod    Production    Global    Taiwan
    Verify WC B2B or Bulk Purchase CTA
# ====================================================================================================



# ====================================================================================================
*** Keywords ***
Verify Footer Logo Not In Homepage
    [Documentation]    Assertion for verifying whether user is redirected to Homepage or not upon clicking 
    ...                logo in footer. Initial position of user is not in homepage.
    Scroll Element Into View    ${img_logoFooter}
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_quickHome}
    Close Modal Pop-up
    Page Should Contain Element    ${unq_bannerActive}

Verify Footer Logo In Homepage
    [Documentation]    Assertion for verifying whether user is redirected to Homepage or not upon clicking 
    ...                logo in footer. Initial position of user is in homepage.
    Scroll Element Into View    ${img_logoFooter}
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_quickHome}
    ${scrollPosition}    Execute Javascript    return window.document.body.scrollTop
    Should Be Equal As Integers    ${scrollPosition}    0

Verify Why Wallet Codes CTA
    [Documentation]    Assertion to verify whether user is redirected to Why Us support page or not upon
    ...                clicking Why Wallet Codes CTA in footer.
    Scroll Element Into View    ${btn_quickWhyWalletCodes}
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_quickWhyWalletCodes}
    Element Should Be Visible    ${unq_whyWalletCodes}

Verify Blog CTA
    [Documentation]    Assertion to verify whether user is redirected to Blog support page or not upon
    ...                clicking Why Wallet Codes CTA in footer.
    Scroll Element Into View    ${img_logoFooter}
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_quickBlog}
    ${currentUrls}    Get Locations
    Should Be Equal    ${url_blog}    ${currentUrls}[1]

Click WC B2B or Bulk Purchase CTA
    [Documentation]    Click on WC B2B or Bulk Purchase CTA in footer.
    IF    $checkTaiwan not in $url_usedUrl
        Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_quickWCB2B}
    ELSE IF     $checkTaiwan in $url_usedUrl
        IF    $checkStaging in $url_usedUrl
            Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_quickWCB2B}
        ELSE IF    $checkPreprod in $url_usedUrl
            Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_quickBulkPurchase}
        ELSE IF    $checkStaging not in $url_usedUrl and $checkPreprod not in $url_usedUrl
            Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_quickBulkPurchase2}
        END
    END

Verify WC B2B or Bulk Purchase CTA
    [Documentation]    Assertion to verify whether user is redirected to WC For Business support page or not 
    ...                upon clicking Why Wallet Codes CTA in footer.
    Scroll Element Into View    ${img_logoFooter}
    Click WC B2B or Bulk Purchase CTA
    ${currentUrls}    Get Locations
    Should Be Equal    ${url_wc4b}    ${currentUrls}[1]
# ====================================================================================================