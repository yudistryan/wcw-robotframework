# ====================================================================================================
*** Settings ***
Documentation    Social Media Section in Footer Test Suite.
...              
...              Test Environment: *${global_env}*
Resource    ../../Resources/imports.resource
Test Tags    Regression
Test Setup    Go to Wallet Codes Website    ${global_env}    chrome    10s
Test Teardown    End Testing
# ====================================================================================================



# ====================================================================================================
*** Variables ***
# ====================================================================================================



# ====================================================================================================
*** Test Cases ***
C9978 Social media - Facebook button
    [Documentation]    Facebook redirection in footer.
    [Tags]    Staging    Preprod    Production    Global    Taiwan
    Scroll to Bottom of Page
    Verify Facebook CTA

C9979 Social media - Instagram button
    [Documentation]    Instagram redirection in footer.
    [Tags]    Staging    Preprod    Production    Global    Taiwan
    Scroll to Bottom of Page
    Click Element    ${btn_instagram}
    Verify Instagram CTA

C9980 Social media - Linkedin button
    [Documentation]    Linkedin redirection in footer.
    [Tags]    Staging    Preprod    Production    Global    Taiwan
    Scroll to Bottom of Page
    Verify Linkedin CTA

C9981 Social media - Youtube button
    [Documentation]    Youtube redirection in footer.
    [Tags]    Staging    Preprod    Production    Global    Taiwan
    Scroll to Bottom of Page
    Verify Youtube CTA
# ====================================================================================================



# ====================================================================================================
*** Keywords ***
Verify Facebook CTA
    [Documentation]    Assertion to verify whether user is redirected to correct facebook page or not.
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_facebook}
    ${currentUrls}    Get Locations
    IF    $checkTaiwan not in $url_usedUrl
        Should Contain    ${currentUrls}[1]    ${url_wcFacebook}
    ELSE IF    $checkTaiwan in $url_usedUrl
        Should Contain    ${currentUrls}[1]    ${url_wcFacebookTW}
    END

Verify Instagram CTA
    [Documentation]    Assertion to verify whether user is redirected to correct instagram page or not.
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_instagram}
    ${currentUrls}    Get Locations
    IF    $checkTaiwan not in $url_usedUrl
        Should Be Equal    ${url_wcInstagram}    ${currentUrls}[1]
    ELSE IF    $checkTaiwan in $url_usedUrl
        Should Be Equal    ${url_wcInstagramTW}    ${currentUrls}[1]       
    END

Verify Linkedin CTA
    [Documentation]    Assertion to verify whether user is redirected to correct linkedin page or not.
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_linkedin}
    ${currentUrls}    Get Locations
    IF    $currentUrls[1] != $url_wcLinkedin
        ${linkedinChecker}=    Create List    www.linkedin.com    company    walletcodes
        FOR    ${item}    IN    @{linkedinChecker}
            Should Contain    ${currentUrls}[1]    ${item}
        END
    ELSE
        Should Be Equal    ${url_wcLinkedin}    ${currentUrls}[1]
    END

Verify Youtube CTA
    [Documentation]    Assertion to verify whether user is redirected to correct youtube page or not.
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_youtube}
    ${currentUrls}    Get Locations
    IF    $checkTaiwan not in $url_usedUrl
        Should Be Equal    ${url_wcYoutube}    ${currentUrls}[1]
    ELSE IF    $checkTaiwan in $url_usedUrl
        Should Be Equal    ${url_wcYoutubeTW}    ${currentUrls}[1]       
    END
# ====================================================================================================