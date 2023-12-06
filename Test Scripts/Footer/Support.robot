# ====================================================================================================
*** Settings ***
Documentation    Support Section in Footer Test Suite. Test Environment: ${global_env}
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
C9986 Support - Support button
    [Documentation]    Support redirection in footer.
    [Tags]    Staging    Preprod    Production    Global    Taiwan
    Check If This is Taiwan Website
    Scroll to Bottom of Page
    Verify Support CTA

C9987 Support - Terms & condition button
    [Documentation]    T&C redirection in footer.
    [Tags]    Staging    Preprod    Production    Global    Taiwan
    Check If This is Taiwan Website
    Scroll to Bottom of Page
    Verify T&C CTA

C9988 Support - Privacy and policy button
    [Documentation]    Privacy and Policy redirection in footer.
    [Tags]    Staging    Preprod    Production    Global    Taiwan
    Check If This is Taiwan Website
    Scroll to Bottom of Page
    Verify Privacy and Policy CTA

C9989 Support - Contact us button
    [Documentation]    Contact Us redirection in footer.
    [Tags]    Staging    Preprod    Production    Global    Taiwan
    Check If This is Taiwan Website
    Scroll to Bottom of Page
    Verify Contact Us CTA
# ====================================================================================================



# ====================================================================================================
*** Keywords ***
Verify Support CTA
    [Documentation]    Assertion to verify whether user is redirected to support page in footer.
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_supportSupport}
    Element Should Be Visible    ${unq_supportPage}

Verify T&C CTA
    [Documentation]    Assertion to verify whether user is redirected to T&C page in footer.
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_terms&conditionSupport}
    Element Should Be Visible    ${unq_t&cPage}

Verify Privacy and Policy CTA
    [Documentation]    Assertion to verify whether user is redirected to privacy and policy page in footer.
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_privacy&policySupport}
    Element Should Be Visible    ${unq_privacyPolicyPage}

Verify Contact Us CTA
    [Documentation]    Assertion to verify whether user is redirected to contact us page in footer.
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_supportContactUs}
    Element Should Be Visible    ${unq_contactUs}
# ====================================================================================================