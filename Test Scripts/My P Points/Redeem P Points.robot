# ====================================================================================================
*** Settings ***
Documentation    P Points Redemption Functionalities and Validations.
...              
...              Test Environment: *${global_env}*
Resource    ../../Resources/imports.resource
Test Tags    Regression
Suite Setup    Go to Wallet Codes Website    ${global_env}    chrome    10
Suite Teardown    End Testing
# ====================================================================================================



# ====================================================================================================
*** Variables ***
# ====================================================================================================



# ====================================================================================================
*** Test Cases ***
C10615 Input invalid code
    [Documentation]    Redeem P Points by inputting invalid code in promo field.
    [Tags]    Staging    Preprod    Production    Global    Taiwan
    ${codes}    Create List    ${invalid_code1}    ${invalid_code2}    ${invalid_code3}
    My P Points Setup
    Verify Invalid P Point Promo Code    @{codes}

C10626 Input empty code
    [Documentation]    Redeem P Points by inputting empty code in promo field.
    [Tags]    Staging    Preprod    Production    Global    Taiwan
    My P Points Setup
    Input Promo Code in P Points Page
    Verify Empty P Point Promo Code

# C10627 Input expired code
# C10628 Input valid code

C10629 P Point CTA
    [Documentation]    P Points page CTA functionality.
    [Tags]    Staging    Preprod    Production    Global    Taiwan
    My P Points Setup
    Verify Learn About P Points in P Points Page
    Go to My P Points Page
# ====================================================================================================



# ====================================================================================================
** Keywords ***
Input Promo Code in P Points Page
    [Documentation]    Fill out promo code field. By default, it's empty.
    [Arguments]    ${code}=${EMPTY}
    Wait Until Keyword Succeeds    10s    1s    Input Text    ${inp_promoCode}    ${code}
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_redeemCode}

Verify Invalid P Point Promo Code
    [Documentation]    Assertion to verify whether p point promo is invalid or not.
    [Arguments]    @{codes}
    FOR    ${invalid_code}    IN    @{codes}
        Input Promo Code in P Points Page    ${invalid_code}
        Set Browser Implicit Wait    2s
        IF    $checkTaiwan not in $url_usedUrl
            IF    $checkStaging in $url_usedUrl or $checkPreprod in $url_usedUrl
                Run Keyword And Continue On Failure    Wait Until Element Is Visible   ${err_invalidPromoCode}    3s
                Run Keyword And Continue On Failure    Click Element   ${err_invalidPromoCode}
            ELSE
                Run Keyword And Continue On Failure    Wait Until Element Is Visible   ${err_invalidPromoCodeTW}    3s
                Run Keyword And Continue On Failure    Click Element   ${err_invalidPromoCodeTW}
            END
        ELSE IF    $checkTaiwan in $url_usedUrl
            Run Keyword And Continue On Failure    Wait Until Element Is Visible   ${err_invalidPromoCodeTW}    3s
            Run Keyword And Continue On Failure    Click Element   ${err_invalidPromoCodeTW}
        END
        Set Browser Implicit Wait    10s
    END
    
Verify Empty P Point Promo Code
    [Documentation]    Assertion to verify whether p point promo is empty or not.
    Run Keyword And Continue On Failure    Wait Until Element Is Visible   ${err_emptyFieldsContactUs}    2s

Verify Learn About P Points in P Points Page
    [Documentation]    Assertion to verify whether user is redirected to P Points support page or not.
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_whatIsPpointRedeemPoint}
    Run Keyword And Continue On Failure    Wait Until Element Is Visible    ${unq_whatIsPPoints}    3s
# ====================================================================================================