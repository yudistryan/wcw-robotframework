# ====================================================================================================
*** Settings ***
Documentation    Checkout Functionalities in Taiwan's Website.
...              
...              Test Environment: *${global_env}*
Resource    ../../Resources/imports.resource
Test Tags    Regression
Suite Setup    Go to Wallet Codes Website    ${global_env}    chrome    10s
Suite Teardown    End Testing
# ====================================================================================================



# ====================================================================================================
*** Variables ***
${txt_alertMessage}    You Will Be Redirected To Payment.....
${url_sonetGateway}    https://mpay-dev.so-net.net.tw/paymentRule.php    #Staging
${url_sonetGateway2}    https://mpay.so-net.net.tw/paymentRule.php    #Preprod and Production
${url_redeemProduct}    https://shop.garena.tw/app
${checkCheckout1}    /garena-shell-70
${checkCheckout2}    /garena-shells-70
${checkCheckout3}    /lineage-m-blue-gems-ntd-300
${checkCheckout4}    /mobile-legends-278-diamonds
${checkWalletCodes}    wallet-codes.com
# ====================================================================================================



# ====================================================================================================
*** Test Cases ***
C11223 UserId and ZoneId are required for Mobile Legend product
    [Documentation]    Emptying UserId and ZoneId fields on Mobile Legend product.
    [Tags]    Staging    Preprod    Production    Taiwan
    Go to Checkout Page TW    Mobile Legends 278
    Verify Empty UserId and ZoneId

C11226 Only valid userId and zoneId are accepted
    [Documentation]    Input valid UserId and ZoneId fields on Mobile Legend product.
    [Tags]    Staging    Preprod    Production    Taiwan
    Go to Checkout Page TW    Mobile Legends 278
    Verify Invalid UserId and ZoneId
    Verify Valid UserId and ZoneId

C10620 Taiwan guest user is not allowed to checkout
    [Documentation]    Try to checkout without login first in Taiwan website.
    [Tags]    Staging    Preprod    Production    Taiwan
    Go to Checkout Page TW
    Verify Available Payment for Taiwan Guest User
    Select Payment Method   FET
    Verify Taiwan Guest User Unable to Checkout

C11224 Option to login/register is displayed for Taiwan guest users in checkout page 
    [Documentation]    Not logged in user trying to checkout will trigger error.
    [Tags]    Staging    Preprod    Production    Taiwan
    Go to Checkout Page TW
    Check If User Has Been Logged Out
    Select Payment Method    CC
    Verify If Login/Register Option is Displayed

C10618 P Points payment method is only displayed for login user
    [Documentation]    P Point payment method won't show for guest user.
    [Tags]    Staging    Preprod    Production    Global    Taiwan
    Go to Checkout Page TW
    Check If User Has Been Logged Out
    Verify P Point Payment Method is not Displayed
    Check If User Has Been Logged In as Unverified User
    Select Payment Method   FET
    Verify P Point Payment Method for Taiwan Logged In User

C10625 P Points is not displayed for login & guest users for Blue Lineage product
    [Documentation]    P Point payment method won't show for guest user.
    [Tags]    Preprod    Production    Taiwan
    Skip If This is Staging Website
    Go to Checkout Page TW    Lineage 300
    Check If User Has Been Logged Out    Lineage 300
    Verify P Point Payment Method is not Displayed
    Check If User Has Been Logged In as Unverified User    product=Lineage 300
    Verify P Point Payment Method is not Displayed

C11222 P Points is disabled when current balance is insufficient
    [Documentation]    Insufficient p point balance will disable p point payment method.
    [Tags]    Staging    Preprod    Production    Taiwan    Global
    Go to Checkout Page TW
    Check If User Has Been Logged In as Unverified User
    Verify P Point is Disabled
    
C10617 Only Taiwan verified user is allowed to checkout
    [Documentation]    Verify if verified user is able to proceed until successfully checkout.
    [Tags]    Staging    Preprod    Production    Taiwan
    Go to Checkout Page TW
    Check If User Has Been Logged In as Unverified User
    Select Payment Method   FET
    Verify Taiwan Unverified User Unable to Checkout
    Check If User Has Been Logged In as Verified User
    Verify Taiwan Verified User Able to Checkout
    
C10622 Payment using Union Pay only allowed in desktop device
    [Documentation]    Union Pay payment method won't allow any checkout in tablet and mobile devices.
    [Tags]    Staging    Preprod    Production    Taiwan    
    Go to Checkout Page TW
    Check If User Has Been Logged In as Verified User
    Select Payment Method   Union Pay
    Verify Only Desktop User Can Procced With UnionPay

C10734 Billing information field validation
    [Documentation]    Validating billing information field such as email, name, etc.
    [Tags]    Staging    Preprod    Production    Taiwan
    Go to Checkout Page TW
    Check If User Has Been Logged In as Verified User
    Select Payment Method    CC
    Verify Error Recipient Email

C10735 Checkout page CTA
    [Documentation]    Verifying any CTA in checkout page.
    [Tags]    Staging    Preprod    Production    Taiwan
    Go to Checkout Page TW
    Check If User Has Been Logged In as Verified User
    Select Payment Method    CC
    Verify Show More Product Description
    Verify Show Less Product Description
    Verify T&C Before Checkout

C11368 Create transaction with pending status
    [Documentation]    Successfully creating transaction with pending status.
    [Tags]    Staging    Taiwan    New
    Skip If This is Preprod Website
    Skip If This is Production Website
    Go to Checkout Page TW
    Check If User Has Been Logged In as Verified User
    Select Payment Method    Virtual ATM
    Proceed to Pending Checkout using Virtual ATM
    Verify Pending Purchase

C11369 Create transaction with cancelled status
    [Documentation]    Successfully creating transaction with cancelled status.
    [Tags]    Staging    Taiwan    New
    Skip If This is Preprod Website
    Skip If This is Production Website
    Go to Checkout Page TW
    Check If User Has Been Logged In as Verified User
    Select Payment Method    CC
    Proceed to Cancelled Checkout using CC
    Verify Cancelled Purchase

# C11370 Create transaction with failed status

C11371 Create transaction with success status
    [Documentation]    Successfully creating transaction with success status.
    [Tags]    Staging    Taiwan    New
    Skip If This is Preprod Website
    Skip If This is Production Website
    Go to Checkout Page TW
    Check If User Has Been Logged In as Verified User
    Select Payment Method    CC
    Proceed to Checkout using CC
    Verify Success Purchase

C11231 Login taiwan users are allowed to purchase products as a gift
    [Documentation]    Verify if verified user is able to proceed until successfully checkout as gift.
    [Tags]    Staging    Preprod    Production    Taiwan
    Go to Checkout Page TW
    Check If User Has Been Logged In as Verified User
    Select Payment Method    CC
    Verify Taiwan Verified User Able to Send as Gift
# ====================================================================================================



# ====================================================================================================
*** Keywords ***
Go to Checkout Page TW
    [Documentation]    Redirect user to checkout page in Taiwan website. Available product: Garena 70,
    ...                Lineage 300, Mobile Legends 278.
    [Arguments]    ${product}=Garena 70
    Skip If This is not Taiwan Website
    ${currentUrl}    Get Location
    IF    $checkWalletCodes not in $currentUrl
        Go To    ${url_usedUrl}
    END
    IF    $product=='Garena 70'
        IF    $checkCheckout1 in $currentUrl or $checkCheckout2 in $currentUrl
            Reload Page
            Wait Until Element Is Visible    ${unq_garenaShells70TW}
        ELSE
            Go to Garena TW Page
            Select Product - Garena Shells 70
        END
    ELSE IF    $product=='Lineage 300'
        IF    $checkCheckout3 in $currentUrl
            Reload Page
            Wait Until Element Is Visible    ${unq_lineageGem300TW}
        ELSE
            Go to Lineage M Blue Page
            Select Product - Lineage M Blue 300
        END
    ELSE IF    $product=='Mobile Legends 278'
        IF    $checkCheckout4 in $currentUrl
            Reload Page
            Wait Until Element Is Visible    ${unq_MLDiamonds278TW}
        ELSE
            Go to Mobile Legends Page
            Select Product - Mobile Legends Diamonds 278
        END
    END
    
Go to Lineage M Blue Page
    [Documentation]    Redirect user to Linage M Blue product page.
    Wait Until Keyword Succeeds    10s    1s    Mouse Over    ${drd_productsTop}
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${opt_lineageMBlueTop}
    Wait Until Element Is Visible    ${unq_lineageMBluePage}

Go to Mobile Legends Page
    [Documentation]    Redirect user to Mobile Legends product page.
    Wait Until Keyword Succeeds    10s    1s    Mouse Over    ${drd_productsTop}
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${opt_mobileLegendsTop}
    Wait Until Element Is Visible    ${unq_diamondMLPage}

Select Product - Garena Shells 70
    [Documentation]    Select Garena Shell with 70 denomination under Garena Shell product page.
    Wait Until Element Is Visible    ${unq_garenaShells70TWCard}
    Sleep    1.5s
    Wait Until Keyword Succeeds    10    1    Mouse Over    ${btn_buyGarenaShells70TW}
    Wait Until Keyword Succeeds    10    1    Click Element    ${btn_buyGarenaShells70TW}
    Wait Until Element Is Visible    ${unq_garenaShells70TW}
    Element Should Be Visible    ${btn_denom70Active}

Select Product - Lineage M Blue 300
    [Documentation]    Select Lineage M Blue with 300 denomination under Lineage M Blue product page.
    Wait Until Element Is Visible    ${unq_lineageGem300TWCard}
    Sleep    1.5s
    Wait Until Keyword Succeeds    10    1    Mouse Over    ${btn_buyLineageGem300TW}
    Wait Until Keyword Succeeds    10    1    Click Element    ${btn_buyLineageGem300TW}
    Wait Until Element Is Visible    ${unq_lineageGem300TW}
    Element Should Be Visible    ${btn_denom300Active}

Select Product - Mobile Legends Diamonds 278
    [Documentation]    Select Mobile Legends Diamonds with 278 denomination under Mobile Legends Diamonds product page.
    Wait Until Element Is Visible    ${unq_MLDiamonds278TWCard}
    Sleep    1.5s
    Wait Until Keyword Succeeds    10    1    Mouse Over    ${btn_buyMLDiamonds278TW}
    Wait Until Keyword Succeeds    10    1    Click Element    ${btn_buyMLDiamonds278TW}
    Wait Until Element Is Visible    ${unq_MLDiamonds278TW}
    Element Should Be Visible    ${btn_denom278Active}

# Select Denomination

Verify Available Payment for Taiwan Guest User
    [Documentation]    Assertion to verify available payment in checkout page for user that hasn't been logged in.
    @{pgws}    Create List    ${btn_pgwFET}    ${btn_pgw7Eleven}    ${btn_pgwFamilyMarket}
    ...    ${btn_pgwVirtualATM}    ${btn_pgwTaiwanMobile}    ${btn_pgwChungHwa}    ${btn_pgwAPT}
    ...    ${btn_pgwUnionPay}    ${btn_pgwCreditCard}
    FOR    ${pgw}    IN    @{pgws}
        Run Keyword And Continue On Failure    Element Should Be Visible    ${pgw}
    END

Verify Available Payment for Taiwan Logged In User
    [Documentation]    Assertion to verify available payment in checkout page for user that has been logged in.
    @{pgws}    Create List    ${btn_pgwFET}    ${btn_pgw7Eleven}    ${btn_pgwFamilyMarket}
    ...    ${btn_pgwVirtualATM}    ${btn_pgwTaiwanMobile}    ${btn_pgwChungHwa}    ${btn_pgwAPT}
    ...    ${btn_pgwUnionPay}    ${btn_pgwCreditCard}    ${btn_pPointsPGW}
    FOR    ${pgw}    IN    @{pgws}
        Run Keyword And Continue On Failure    Element Should Be Visible    ${pgw}
    END

Verify P Point Payment Method for Taiwan Logged In User
    [Documentation]    Assertion to verify whether P Point is visible or not for user that has been logged in
    ...                Taiwan website.
    Run Keyword And Continue On Failure    Wait Until Element Is Visible    ${btn_pPointsPGW}    5s

Verify P Point Payment Method is not Displayed
    [Documentation]    Assertion to verify whether P Point isn't visible or not.
    Run Keyword And Continue On Failure    Scroll Element Into View    ${unq_step2Checkout}
    Run Keyword And Continue On Failure    Element Should Not Be Visible    ${btn_pPointsPGW}

Verify Taiwan Guest User Unable to Checkout
    [Documentation]    Assertion to verify whether user that hasn't been logged in is able to checkout or not.
    @{elements}    Create List    ${err_loginBeforeCheckout}    ${btn_loginCheckout}    
    ...    ${btn_registerCheckout}
    FOR    ${element}    IN    @{elements}
        Run Keyword And Continue On Failure    Element Should Be Visible    ${element}
    END
    Run Keyword And Continue On Failure    Element Should Be Disabled    ${btn_buyNow}

Log in Through Modal in Checkout as ${user_type} User
    [Documentation]    Log in via Login button in checkout page as desired user. Available user type:
    ...                Unverified and Verified.
    Wait Until Keyword Succeeds    10    1    Click Element    ${btn_loginCheckout}
    Wait Until Element Is Visible    ${unq_loginCheckoutModal}
    IF    $user_type == "Unverified"
        Wait Until Keyword Succeeds    10    1    Input Text    ${inp_emailLoginCheckout}    ${valid_email2}
        Wait Until Keyword Succeeds    10    1    Input Text    ${inp_passwordLoginCheckout}    ${valid_password}
    ELSE IF    $user_type == "Verified"
        IF    $checkStaging in $url_usedUrl or 'C11222' in $TEST_NAME
            Wait Until Keyword Succeeds    10    1    Input Text    ${inp_emailLoginCheckout}    ${valid_email5}
            Wait Until Keyword Succeeds    10    1    Input Text    ${inp_passwordLoginCheckout}    ${valid_password}
        ELSE
            Wait Until Keyword Succeeds    10    1    Input Text    ${inp_emailLoginCheckout}    ${valid_email3}
            Wait Until Keyword Succeeds    10    1    Input Text    ${inp_passwordLoginCheckout}    ${valid_password3}
        END
    END
    Wait Until Element Is Visible    ${unq_recaptchaContactUs}
    Execute Manual Step    Please bypass recaptcha
    Wait Until Keyword Succeeds    10    1    Click Element    ${btn_submitLoginCheckout}
    Wait Until Element Is Not Visible    ${unq_loginCheckoutModal}    15s

Check User's Logged In Status
    [Documentation]    Check whether current user is logged in or not.
    ${before}    Get Selenium Implicit Wait
    Set Selenium Implicit Wait    3s
    ${guestUser}    Run Keyword And Return Status    Element Should Be Visible    ${err_loginBeforeCheckout}
    ${unverified}    Run Keyword And Return Status   Element Should Be Visible    ${err_verifyPhoneNumberCheckout}
    ${unexpected_error}    Run Keyword And Return Status    Element Should Be Visible    ${err_unexpectedErrorInCheckout}
    @{status}    Create List    ${guestUser}    ${unverified}    ${unexpected_error}
    Set Selenium Implicit Wait    ${before}
    RETURN    @{status}

Log out
    [Documentation]    Try log out from current logged in user.
    Wait Until Keyword Succeeds    10    1    Mouse Over    ${drd_myAccountsTop}
    Wait Until Keyword Succeeds    10    1    Click Element    ${opt_logout}
    Close Modal Pop-up
    Wait Until Element Is Not Visible    ${drd_myAccountsTop}    2s

Check If Payment Method is Selected
    [Documentation]    Check whether a payment method is selected or not. It's affect the checkout flow so
    ...                it needs to be checked.
    [Arguments]    ${payment}=Virtual ATM
    ${before}    Get Selenium Implicit Wait
    Set Selenium Implicit Wait    1s
    ${selected}    Run Keyword And Return Status    Element Should Be Visible    ${btn_pgwWildCardsActive}
    IF    not $selected
        Select Payment Method    ${payment}
    END
    Set Selenium Implicit Wait    ${before}

Check If User Has Been Logged In as Verified User
    [Documentation]    Check whether current user is logged in or not. If so, is it verified or not. If not
    ...                logged in, it will try to log in as verified user. While if user has been logged in as
    ...                unverified user, it will log out and re-log in as verified user. If user has been logged
    ...                in as verified user, it will go to desired product page. Available product: Garena 70,
    ...                Lineage 300, Mobile Legends 278.
    # status[0] -> Unverified
    # status[1] -> Guest User
    # status[2] -> Unexpected Error
    [Arguments]    ${product}=Garena 70
    Check If Payment Method is Selected
    ${status}    Check User's Logged In Status
    IF    $status[0]    
        Log in Through Modal in Checkout as Verified User
    ELSE IF    $status[1]
        Log out
        Close Modal Pop-up
        Go to Checkout Page TW    ${product}
        Select Payment Method    Virtual ATM
        Log in Through Modal in Checkout as Verified User
    ELSE
        ${before}    Get Selenium Implicit Wait
        Set Selenium Implicit Wait    1s
        ${guestUser}    Run Keyword And Return Status    Element Should Not Be Visible    ${drd_myAccountsTop}
        Set Selenium Implicit Wait    ${before}
        IF    $guestUser
            Check If Payment Method is Selected
            IF    $checkStaging in $url_usedUrl or 'C11222' in $TEST_NAME
                Log in to Wallet Codes website    ${valid_email5}    ${valid_password}    ${False}
            ELSE
                Log in to Wallet Codes website    ${valid_email3}    ${valid_password3}    ${False}
            END
        ELSE
            Wait Until Keyword Succeeds    10    1    Mouse Over    ${drd_myAccountsTop}
            Wait Until Keyword Succeeds    10    1    Click Element    ${opt_myAccounts}
            Wait Until Element Is Visible    ${unq_myProfilePage}
            ${email_text}    Get Text    ${txt_emailMyProfile}
            ${splitted_text}    Split String    ${email_text}
            ${current_email}    Set Variable    ${splitted_text}[-1]
            @{verified_emails}    Create List    ${valid_email3}    ${valid_email5}
            IF    $current_email in $verified_emails
                Go to Checkout Page TW    ${product}
            ELSE
                Log out
                IF    $checkStaging in $url_usedUrl or 'C11222' in $TEST_NAME
                    Log in to Wallet Codes website    ${valid_email5}    ${valid_password}    ${False}
                ELSE
                    Log in to Wallet Codes website    ${valid_email3}    ${valid_password3}    ${False}
                END
                Go to Checkout Page TW    ${product}
            END
        END
    END

Check If User Has Been Logged In as Unverified User
    [Documentation]    Check whether current user is logged in or not. If so, is it unverified or not. If not
    ...                logged in, it will try to log in as unverified user. While if user has been logged in as
    ...                verified user, it will log out and re-log in as unverified user. If user has been logged
    ...                in as unverified user, it will go to desired product page. Available product: Garena 70,
    ...                Lineage 300, Mobile Legends 278.
    [Arguments]    ${product}=Garena 70
    # status[0] -> Guest user
    # status[1] -> Unverified
    Check If Payment Method is Selected
    ${status}    Check User's Logged In Status
    IF    $status[0]
        Log in Through Modal in Checkout as Unverified User
    ELSE IF    $status[2]
        ${before}    Get Selenium Implicit Wait
        Set Selenium Implicit Wait    1s
        ${guestUser}    Run Keyword And Return Status    Element Should Not Be Visible    ${drd_myAccountsTop}
        Set Selenium Implicit Wait    ${before}
        IF    $guestUser
            Check If Payment Method is Selected
            IF    $checkStaging in $url_usedUrl
                Log in to Wallet Codes website    ${valid_email5}    ${valid_password}    ${False}
            ELSE
                Log in to Wallet Codes website    ${valid_email3}    ${valid_password3}    ${False}
            END
        ELSE
            Wait Until Keyword Succeeds    10    1    Mouse Over    ${drd_myAccountsTop}
            Wait Until Keyword Succeeds    10    1    Click Element    ${opt_myAccounts}
            Wait Until Element Is Visible    ${unq_myProfilePage}
            ${email_text}    Get Text    ${txt_emailMyProfile}
            ${splitted_text}    Split String    ${email_text}
            ${current_email}    Set Variable    ${splitted_text}[-1]
            @{verified_emails}    Create List    ${valid_email3}    ${valid_email5}
            IF    $current_email not in $verified_emails
                Go to Checkout Page TW    ${product}
            ELSE
                Log out
                Log in to Wallet Codes website    ${valid_email2}    ${valid_password}    ${False}
                Go to Checkout Page TW    ${product}
            END
        END
    ELSE IF    not $status[1]
        Log out
        Close Modal Pop-up
        Log in to Wallet Codes website    english=${False}
        Go to Checkout Page TW    ${product}
    END

Check If User Has Been Logged Out
    [Documentation]    Check whether user has been logged out or not. If not, it will try to log out. If already
    ...                logged out, it will go to desired product. Available product: Garena 70, Lineage 300,
    ...                Mobile Legends 278.
    # Status[0] -> Guest User
    [Arguments]    ${product}='Garena 70'
    Check If Payment Method is Selected
    ${status}    Check User's Logged In Status
    IF    not $status[0]
        Log out
        Go to Checkout Page TW    ${product}
    END

Verify Taiwan Unverified User Unable to Checkout
    [Documentation]    Assertion to verify whether unverified user able to checkout or not.
    Run Keyword And Continue On Failure    Element Should Be Visible    ${err_verifyPhoneNumberCheckout}
    Run Keyword And Continue On Failure    Element Should Be Disabled    ${btn_buyNow}

Verify Taiwan Verified User Able to Checkout
    [Documentation]    Assertion to verify whether verified user able to checkout or not.
    Check If Payment Method is Selected
    IF    $checkStaging in $url_usedUrl or $checkPreprod in $url_usedUrl
        Run Keyword And Continue On Failure    Element Should Be Visible    ${unq_billingInformation}
    ELSE
        Run Keyword And Continue On Failure    Element Should Be Visible    ${unq_billingInformation2}
    END
    Run Keyword And Continue On Failure    Element Should Be Enabled    ${btn_buyNow}

Verify Taiwan Verified User Able to Send as Gift
    [Documentation]    Assertion to verify whether verified user able to checkout as gift or not.
    Wait Until Keyword Succeeds    10    1    Click Element    ${box_sendAsGift}
    Wait Until Keyword Succeeds    10    1    Input Text    ${inp_recipientEmail}    ${valid_email}
    Wait Until Keyword Succeeds    10    1    Click Element    ${box_checkboxTnC}
    Wait Until Keyword Succeeds    10    1    Click Element    ${btn_buyNow}
    Alert Should Be Present    ${txt_alertMessage}    timeout=15s
    Wait Until Element Is Visible    ${unq_unionPayCCSonet}    15s
    ${currentUrl}    Get Location
    IF    $checkStaging in $url_usedUrl
        Should Match    ${currentUrl}    ${url_sonetGateway}
    ELSE
        Should Match    ${currentUrl}    ${url_sonetGateway2}
    END

Verify Only Desktop User Can Procced With UnionPay
    [Documentation]    Assertion to verify whether user that's using desktop able to checkout using UnionPay
    ...                or not.
    Wait Until Keyword Succeeds    10    1    Click Element    ${box_checkboxTnC}
    Wait Until Keyword Succeeds    10    1    Click Element    ${btn_buyNow}
    Alert Should Be Present    ${txt_alertMessage}    timeout=15s
    Wait Until Element Is Visible    ${unq_unionPayCCSonet}    15s
    ${currentUrl}    Get Location
    IF    $checkStaging in $url_usedUrl
        Should Match    ${currentUrl}    ${url_sonetGateway}
    ELSE
        Should Match    ${currentUrl}    ${url_sonetGateway2}
    END
    Go Back

Proceed to Pending Checkout using Virtual ATM
    [Documentation]    Continue process of creating pending transaction by selecting Virtual ATM as payment 
    ...                method.
    Wait Until Keyword Succeeds    10    1    Click Element    ${box_checkboxTnC}
    Wait Until Keyword Succeeds    10    1    Click Element    ${btn_buyNow}
    Alert Should Be Present    ${txt_alertMessage}    timeout=15s
    Wait Until Element Is Visible    ${unq_VirtualATMSonet}    15s
    ${currentUrl}    Get Location
    IF    $checkStaging in $url_usedUrl
        Should Match    ${currentUrl}    ${url_sonetGateway}
    ELSE
        Should Match    ${currentUrl}    ${url_sonetGateway2}
    END
    Wait Until Keyword Succeeds    10    1    Input Text    ${inp_recipientNameSonet}    ${valid_name}
    Wait Until Keyword Succeeds    10    1    Input Text    ${inp_recipientEmailSonet}    ${valid_email}
    Wait Until Keyword Succeeds    10    1    Click Element    ${btn_agreeSonet}

Proceed to Cancelled Checkout using CC
    [Documentation]    Continue process of creating cancelled transaction by selecting Credit Card as payment 
    ...                method.
    Wait Until Keyword Succeeds    10    1    Click Element    ${box_checkboxTnC}
    Wait Until Keyword Succeeds    10    1    Click Element    ${btn_buyNow}
    Alert Should Be Present    ${txt_alertMessage}    timeout=15s
    Wait Until Element Is Visible    ${unq_unionPayCCSonet}    15s
    ${currentUrl}    Get Location
    IF    $checkStaging in $url_usedUrl
        Should Match    ${currentUrl}    ${url_sonetGateway}
    ELSE
        Should Match    ${currentUrl}    ${url_sonetGateway2}
    END
    Wait Until Keyword Succeeds    10    1    Click Element    ${btn_disagreeSonet}

Proceed to Checkout using CC
    [Documentation]    Continue process of creating transaction by selecting Credit Card as payment 
    ...                method.
    Wait Until Keyword Succeeds    10    1    Click Element    ${box_checkboxTnC}
    Wait Until Keyword Succeeds    10    1    Click Element    ${btn_buyNow}
    Alert Should Be Present    ${txt_alertMessage}    timeout=10s
    Wait Until Element Is Visible    ${unq_unionPayCCSonet}    15s
    ${currentUrl}    Get Location
    Should Match    ${currentUrl}    ${url_sonetGateway}
    Wait Until Keyword Succeeds    10    1    Input Text    ${inp_recipientNameSonet}    ${valid_name2}
    Wait Until Keyword Succeeds    10    1    Input Text    ${inp_recipientEmailSonet}    ${valid_email}
    Wait Until Keyword Succeeds    10    1    Click Element    ${btn_agreeSonet}
    Wait Until Element Is Visible    ${inp_ccNumber1Sonet}
    Wait Until Keyword Succeeds    10    1    Input Text    ${inp_ccNumber1Sonet}    ${valid_cc1}
    Wait Until Keyword Succeeds    10    1    Input Text    ${inp_ccNumber2Sonet}    ${valid_cc2}
    Wait Until Keyword Succeeds    10    1    Input Text    ${inp_ccNumber3Sonet}    ${valid_cc2}
    Wait Until Keyword Succeeds    10    1    Input Text    ${inp_ccNumber4Sonet}    ${valid_cc2}
    Wait Until Keyword Succeeds    10    1    Input Text    ${inp_cvcSonet}    ${cvc}
    Wait Until Keyword Succeeds    10    1    Click Element    ${drd_expireMonthSonet}
    Wait Until Keyword Succeeds    10    1    Click Element    ${opt_decemberMonthSonet}
    Wait Until Keyword Succeeds    10    1    Click Element    ${drd_expireYearSonet}
    Wait Until Keyword Succeeds    10    1    Click Element    ${opt_2038YearSonet}
    Execute Manual Step    Please bypass authentication
    Wait Until Keyword Succeeds    10    1    Click Element    ${btn_submitCCSonet}

Verify Pending Purchase
    [Documentation]    Assertion to verify whether checkout status is pending or not. It will assert in 
    ...                thank you page.
    IF    $checkStaging in $url_usedUrl
        Wait Until Element Is Visible    ${unq_thankyouPage}    10s
        Wait Until Element Is Visible    ${txt_paymentStatusTYPage}    20s
        ${status}    Get Text    ${txt_paymentStatusTYPage}
        Should Match    ${status}    Pending    ignore_case=${True}
    ELSE
        Wait Until Element Is Visible    ${unq_VirtualATMSonetOTP}    10s
        Go Back
        Go Back
        Wait Until Element Is Visible    ${drd_myAccountsTop}
        Wait Until Keyword Succeeds    10    1    Mouse Over    ${drd_myAccountsTop}
        Wait Until Keyword Succeeds    10    1    Click Element    ${opt_transactionHistory}
    END
    
Verify Cancelled Purchase
    [Documentation]    Assertion to verify whether checkout status is cancelled or not. It will assert in 
    ...                thank you page.
    Wait Until Element Is Visible    ${unq_thankyouPage}    10s
    Wait Until Element Is Visible    ${txt_paymentStatusTYPage}    10s
    ${status}    Get Text    ${txt_paymentStatusTYPage}
    Should Match    ${status}    Cancelled    ignore_case=${True}

Verify Success Purchase
    [Documentation]    Assertion to verify whether checkout status is success or not. It will assert in 
    ...                thank you page.
    Wait Until Element Is Visible    ${unq_thankyouPage}    15s
    Element Should Be Visible    ${unq_successPayment}
    Wait Until Element Is Visible    ${txt_paymentStatusTYPage}    10s
    ${status}    Get Text    ${txt_paymentStatusTYPage}
    Should Match    ${status}    Success    ignore_case=${True}

Verify Error Recipient Email
    [Documentation]    Assertion to verify error message in recipient email field under sent as gift section.
    @{emails}    Create List    ${invalid_email1}    ${invalid_email2}    ${invalid_email3}
    ...    ${invalid_email4}    ${invalid_email6}    #${invalid_email5}    ${invalid_email7}
    ...    ${invalid_email8}
    IF    $checkTaiwan not in $url_usedUrl
        Wait Until Element Is Visible    ${inp_emailBillingInfo}    
        Scroll Element Into View    ${inp_emailBillingInfo}
        Wait Until Keyword Succeeds    10    1    Input Text    ${inp_emailBillingInfo}    ${valid_email}
        Wait Until Keyword Succeeds    10    1    Input Text    ${inp_phoneNumberBillingInfo}    ${valid_phoneNumber2}
    END
    Wait Until Element Is Visible    ${box_sendAsGift}
    Scroll Element Into View    ${box_sendAsGift}
    Wait Until Keyword Succeeds    10    1    Click Element    ${box_sendAsGift}
    Wait Until Keyword Succeeds    10    1    Click Element    ${box_checkboxTnC}
    Wait Until Keyword Succeeds    10    1    Click Element    ${btn_buyNow}
    Run Keyword And Continue On Failure    Wait Until Element Is Visible    ${err_emptyRecipientEmail}    timeout=3s
    Run Keyword And Continue On Failure    Click Element   ${err_emptyRecipientEmail}
    Run Keyword And Continue On Failure    Element Should Be Visible    ${err_invalidRecipientEmail}
    FOR    ${email}    IN    @{emails}
        Wait Until Keyword Succeeds    10    1    Input Text    ${inp_recipientEmail}    ${email}
        Wait Until Keyword Succeeds    10    1    Click Element    ${btn_buyNow}
        Run Keyword And Continue On Failure    Wait Until Element Is Visible    ${err_emptyRecipientEmail}    timeout=3s
        Run Keyword And Continue On Failure    Click Element    ${err_emptyRecipientEmail}
        Run Keyword And Continue On Failure    Element Should Be Visible    ${err_invalidRecipientEmail}
    END

Verify If Login/Register Option is Displayed
    [Documentation]    Assertion to verify whether error message is appeared or not. This error message is
    ...                triggered when user not logged in and go to checkout page.
    Run Keyword And Continue On Failure    Element Should Be Visible    ${err_loginBeforeCheckout}

Verify P Point is Disabled
    [Documentation]    Assertion to verify if P Point payment is disabled or not. It's only triggered when
    ...                P Point balance is sufficient.
    Scroll Element Into View    ${unq_step2Checkout}
    Run Keyword And Continue On Failure    Wait Until Element Is Visible    ${btn_pgwPPointsDisabled}    10s

Verify Empty UserId and ZoneId
    [Documentation]    Assertion to verify if UserId and ZoneId are empty or not.
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_verifyZoneUserId}
    Run Keyword And Continue On Failure    Wait Until Element Is Visible    ${err_userIdRequired}    3s
    Run Keyword And Continue On Failure    Element Should Be Visible    ${err_zoneIdRequired}

Verify Invalid UserId and ZoneId
    [Documentation]    Assertion to verify if UserId and ZoneId are invalid or not.
    Wait Until Keyword Succeeds    10s    1s    Input Text    ${inp_userIdCheckout}    ${invalid_userId1}
    Wait Until Keyword Succeeds    10s    1s    Input Text    ${inp_zoneIdCheckout}    ${invalid_zoneId1}
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_verifyZoneUserId}
    Run Keyword And Continue On Failure    Wait Until Element Is Visible    ${err_userZoneIdNotFound}    3s
    ${rawText}    Get Text    ${err_userZoneIdNotFound}
    ${userId}    Get User Id From Message    ${rawText}
    ${zoneId}    Get Zone Id From Message    ${rawText}
    Should Match    ${userId}    ${invalid_userId1}
    Should Match    ${zoneId}    ${invalid_zoneId1}

Verify Valid UserId and ZoneId
    [Documentation]    Assertion to verify if UserId and ZoneId are valid or not.
    Wait Until Keyword Succeeds    10s    1s    Input Text    ${inp_userIdCheckout}    ${valid_userId}
    Wait Until Keyword Succeeds    10s    1s    Input Text    ${inp_zoneIdCheckout}    ${valid_zoneId}
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_verifyZoneUserId}
    Run Keyword And Continue On Failure    Wait Until Element Is Visible    ${unq_userZoneIdFound}    3s
    ${rawText}    Get Text    ${unq_userZoneIdFound}
    ${userId}    Get User Id From Message   ${rawText}
    ${zoneId}    Get Zone Id From Message    ${rawText}
    ${username}    Get Username From Success Message    ${rawText}
    Should Match    ${userId}    ${valid_userId}
    Should Match    ${zoneId}    ${valid_zoneId}
    Should Match    ${username}    ${valid_MLUsername}
# ====================================================================================================