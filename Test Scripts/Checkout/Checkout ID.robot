# ====================================================================================================
*** Settings ***
Documentation    Checkout Functionalities in Indonesia's Website.
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
${url_securepayGateway}    https://securepay.e-ghl.com/IPG/Payment.aspx
${url_redeemProduct}    https://shop.garena.tw/app
${checkCheckout1}    /garena-shell-33
${checkCheckout2}    /garena-shells-33
# ====================================================================================================



# ====================================================================================================
*** Test Cases ***
C10616 Non-Taiwan guest user is allowed to checkout
    [Documentation]    Verify if user that's not logged in is able to proceed until successfully checkout.
    [Tags]    Staging    Global    New
    Checkout in Indonesia Setup
    Check If It's Guest User
    Select Payment Method    CC
    Proceed to Checkout
    Verify Guest User is Allowed to Checkout

C10733 Non-Taiwan guest user is allowed to send as gift
    [Documentation]    Verify if user that's not logged in is able to proceed until successfully checkout
    ...                as gift.
    [Tags]    Staging    Global    New
    Checkout in Indonesia Setup
    Check If It's Guest User
    Select Payment Method    CC
    Proceed to Send as Gift
    Verify Guest User is Allowed to Send as Gift

C10725 Non-Taiwan login user is allowed to checkout
    [Documentation]    Verify if user that's been logged in is able to proceed until successfully checkout.
    [Tags]    Staging    Global    New
    Checkout in Indonesia Setup
    Select Payment Method    CC
    Proceed to Checkout
    Check If User is Already Logged In
    Verify Logged In User is Allowed to Checkout

C10729 Non-Taiwan login user is allowed to send as gift
    [Documentation]    Verify if user that's been logged in is able to proceed until successfully checkout
    ...                as gift.
    [Tags]    Staging    Global    New
    Checkout in Indonesia Setup
    Select Payment Method    CC
    Proceed to Send as Gift
    Check If User is Already Logged In
    Verify Logged In User is Allowed to Send as Gift

C10734 Billing information field validation
    [Documentation]    Validating billing information field such as email, name, etc.
    [Tags]    Staging    Global    New
    Checkout in Indonesia Setup
    Select Payment Method    CC
    Verify Error Recipient Email

C10735 Checkout page CTA
    [Documentation]    Verifying any CTA in checkout page.
    [Tags]    Staging    Global    New
    Checkout in Indonesia Setup
    Select Payment Method    CC
    Verify Show More Product Description
    Verify Show Less Product Description
    Verify T&C Before Checkout

# Missing TCs
C11368 Create transaction with pending status
    [Documentation]    Successfully creating transaction with pending status.
    [Tags]    Staging    Global    New
    Checkout in Indonesia Setup
    Select Payment Method    CC
    Proceed to Pending Checkout as Guest User
    Verify Pending Purchase

# CTW02 Create transaction with cancelled status
# CTW03 Create transaction with failed status
# CTW04 Create transaction with success status
# ====================================================================================================



# ====================================================================================================
*** Keywords ***
Checkout in Indonesia Setup
    [Documentation]    Configuration before executing test steps in Checkout in Indonesia test suite.
    Skip If This is Taiwan Website
    Skip If This is Preprod Website
    Skip If This is Production Website    
    ${currentUrl}    Get Location
    IF    $checkCheckout1 in $url_usedUrl or $checkCheckout2 in $url_usedUrl
        Reload Page
        Wait Until Element Is Visible    ${unq_garenaShells33ID}
    ELSE
        Go To    ${url_usedUrl}
        Check If This is Taiwan Website
        Go to Checkout Page ID
    END

Go to Checkout Page ID
    [Documentation]    Redirect user to checkout page of a product. Current product is Garena Shell 33.
    ${currentUrl}    Get Location
    IF    $checkCheckout1 in $currentUrl or $checkCheckout2 in $currentUrl
        Reload Page
        Wait Until Element Is Visible    ${unq_garenaShells33ID}
    ELSE
        Go to Garena ID Page
        Select Product - Garena Shells 33
    END
    
Go to Garena ID Page
    [Documentation]    Redirect user to product page. Current product is Garena Shell.
    Wait Until Keyword Succeeds    10s    1s    Mouse Over    ${drd_productsTop}
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${opt_shellGarenaProduct}
    Wait Until Element Is Visible    ${unq_garenaShellsTW2}

Select Product - Garena Shells 33
    [Documentation]    Select denomination of a product. Current denomination is 33.
    Wait Until Element Is Visible    ${unq_garenaShells33IDCard}
    Sleep    1.5s
    Wait Until Keyword Succeeds    10s    1s    Mouse Over    ${btn_buyGarenaShells33ID}
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_buyGarenaShells33ID}
    Wait Until Element Is Visible    ${unq_garenaShells33ID}
    Element Should Be Visible    ${btn_denom33active}

# Select Denomination

Log in Through Modal in Checkout
    [Documentation]    Log in through login button that only triggered when guest user is in checkout page.
    Wait Until Element Is Visible    ${unq_loginCheckoutModal}
    Wait Until Keyword Succeeds    10s    1s    Input Text    ${inp_emailLoginCheckout}    ${valid_email2}
    Wait Until Keyword Succeeds    10s    1s    Input Text    ${inp_passwordLoginCheckout}    ${valid_password}
    Wait Until Element Is Visible    ${unq_recaptchaContactUs}
    Execute Manual Step    Please bypass recaptcha
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_submitLoginCheckout}
    Wait Until Element Is Visible    ${drd_myAccountsTop}

Log out
    Wait Until Keyword Succeeds    10s    1s    Mouse Over    ${drd_myAccountsTop}
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${opt_logout}

Check If Payment Method is Selected
    [Documentation]    Check whether a payment method is selected or not. It's affect the checkout flow so
    ...                it needs to be checked.
    [Arguments]    ${payment}=CC
    ${before}    Get Selenium Implicit Wait
    Set Selenium Implicit Wait    1s
    ${selected}    Run Keyword And Return Status    Element Should Be Visible    ${btn_pgwWildCardsActive}
    Set Selenium Implicit Wait    ${before}
    IF    not $selected
        Select Payment Method    ${payment}
    END

Check If It's Guest User
    [Documentation]    Check whether current user is guest user or not. If not will try to log out.
    Check If Payment Method is Selected
    ${logged_in}    Check Log In
    IF    $logged_in
        Log out
        Go to Checkout Page ID
    END

Proceed to Checkout
    [Documentation]    Continue process of creating transaction until clicking Buy Now button.
    Wait Until Element Is Visible    ${unq_billingInformation}
    Wait Until Keyword Succeeds    10s    1s    Input Text    ${inp_emailBillingInfo}    ${valid_email2}
    Wait Until Keyword Succeeds    10s    1s    Input Text    ${inp_phoneNumberBillingInfo}    ${valid_phoneNumber2}
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${box_checkboxTnC}
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_buyNow}

Proceed to Send as Gift
    [Documentation]    Continue process of creating transaction as gift until clicking Buy Now button.
    Wait Until Element Is Visible    ${unq_billingInformation}
    Wait Until Keyword Succeeds    10s    1s    Input Text    ${inp_emailBillingInfo}    ${valid_email2}
    Wait Until Keyword Succeeds    10s    1s    Input Text    ${inp_phoneNumberBillingInfo}    ${valid_phoneNumber2}
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${box_sendAsGift}
    Wait Until Keyword Succeeds    10s    1s    Input Text    ${inp_recipientEmail}    ${valid_email}
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${box_checkboxTnC}
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_buyNow}

Verify Guest User is Allowed to Checkout
    [Documentation]    Assertion to verify if guest user is able to checkout.
    Wait Until Element Is Visible    ${unq_loginCheckoutModal}
    Sleep    0.5s
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_continueAsGuest}
    Alert Should Be Present    ${txt_alertMessage}    timeout=10s
    Wait Until Element Is Visible    ${unq_ccSecurePay}    10s
    ${currentUrl}    Get Location
    Should Match    ${currentUrl}    ${url_securepayGateway}
    Go Back

Verify Guest User is Allowed to Send as Gift
    [Documentation]    Assertion to verify if guest user is able to checkout as gift.
    Wait Until Element Is Visible    ${unq_loginCheckoutModal}
    Sleep    0.5s
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_continueAsGuest}
    Alert Should Be Present    ${txt_alertMessage}    timeout=10s
    Wait Until Element Is Visible    ${unq_ccSecurePay}    10s
    ${currentUrl}    Get Location
    Should Match    ${currentUrl}    ${url_securepayGateway}
    Go Back

Verify Logged In User is Allowed to Checkout
    [Documentation]    Assertion to verify if logged in user is able to checkout.
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_buyNow}
    Alert Should Be Present    ${txt_alertMessage}    timeout=10s
    Wait Until Element Is Visible    ${unq_ccSecurePay}    10s
    ${currentUrl}    Get Location
    Should Match    ${currentUrl}    ${url_securepayGateway}
    Go Back

Verify Logged In User is Allowed to Send as Gift
    [Documentation]    Assertion to verify if logged in user is able to checkout as gift.
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_buyNow}
    Alert Should Be Present    ${txt_alertMessage}    timeout=10s
    Wait Until Element Is Visible    ${unq_ccSecurePay}    10s
    ${currentUrl}    Get Location
    Should Match    ${currentUrl}    ${url_securepayGateway}
    Go Back

Proceed to Checkout using CC for Guest User
    [Documentation]    Continue process of creating transaction as guest user by selecting Credit Card as  
    ...                payment method. It's until assertion of transaction status whether it's succeed or not.
    Wait Until Keyword Succeeds    10s    1s    Input Text    ${inp_emailBillingInfo}    ${valid_email2}
    Wait Until Keyword Succeeds    10s    1s    Input Text    ${inp_phoneNumberBillingInfo}    ${valid_phoneNumber2}
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${box_checkboxTnC}
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_buyNow}
    Wait Until Element Is Visible    ${unq_loginCheckoutModal}
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_continueAsGuest}
    Alert Should Be Present    ${txt_alertMessage}    timeout=10s
    Wait Until Element Is Visible    ${unq_ccSecurePay}    10s
    ${currentUrl}    Get Location
    Should Match    ${currentUrl}    ${url_securepayGateway}
    Wait Until Keyword Succeeds    10s    1s    Input Text    ${inp_cardholderSecurePay}    ${valid_name2}    
    Wait Until Keyword Succeeds    10s    1s    Input Text    ${inp_cardNumber1SecurePay}    ${valid_cc1}
    Wait Until Keyword Succeeds    10s    1s    Input Text    ${inp_cardNumber2SecurePay}    ${valid_cc2}
    Wait Until Keyword Succeeds    10s    1s    Input Text    ${inp_cardNumber3SecurePay}    ${valid_cc2}
    Wait Until Keyword Succeeds    10s    1s    Input Text    ${inp_cardNumber4SecurePay}    ${valid_cc2}
    Wait Until Keyword Succeeds    10s    1s    Input Text    ${inp_cvcSonet}    ${cvc}
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${drd_expireMonthSecurePay}
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${opt_decemberMonthSecurePay}
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${drd_expireMonthSecurePay}
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${opt_2037YearSecurePay}
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_submitCCSecurePay}
    Wait Until Element Is Visible    ${unq_failedPaymentSecurePay}
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_returnToWalletCodes}
    Wait Until Element Is Visible    ${unq_thankyouPage}    10s
    Element Should Be Visible    locator

Proceed to Pending Checkout as Guest User
    [Documentation]    Continue process of creating transaction as guest suer by selecting Credit Card as  
    ...                payment method. It's until assertion of transaction status whether it's pending or not.
    Wait Until Element Is Visible    ${inp_emailBillingInfo}
    Wait Until Keyword Succeeds    10s    1s    Input Text    ${inp_emailBillingInfo}    ${valid_email2}
    Wait Until Keyword Succeeds    10s    1s    Input Text    ${inp_phoneNumberBillingInfo}    ${valid_phoneNumber2}
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${box_checkboxTnC}
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_buyNow}
    ${before}    Get Selenium Implicit Wait
    Set Selenium Implicit Wait    1s
    ${logged_in}    Run Keyword And Return Status    Element Should Be Visible    ${drd_myAccountsTop}
    Set Selenium Implicit Wait    ${before}
    IF    not $logged_in
        Wait Until Element Is Visible    ${unq_loginCheckoutModal}
        Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_continueAsGuest}
    END
    Alert Should Be Present    ${txt_alertMessage}    timeout=10s
    Wait Until Element Is Visible    ${unq_ccSecurePay}    10s
    ${currentUrl}    Get Location
    Should Match    ${currentUrl}    ${url_securepayGateway}
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_cancelPaymentSecurePay}
    Wait Until Element Is Visible    ${unq_thankyouPage}    10s
    
Verify Pending Purchase
    [Documentation]    Assertion to verify whether transaction is pending or not.
    ${status}    Get Text    ${txt_paymentStatusTYPage}
    Should Match    ${status}    Pending    ignore_case=${True}

Verify Success Purchase
    [Documentation]    Assertion to verify whether transaction is success or not.
    Element Should Be Visible    ${unq_successPayment}

Verify Error Recipient Email
    [Documentation]    Assertion to verify whether error is shown upon inputting invalid emails in recipient
    ...                email field under send as gift section.
    @{emails}    Create List    ${invalid_email1}    ${invalid_email2}    ${invalid_email3}
    ...    ${invalid_email4}    ${invalid_email6}    #${invalid_email5}    ${invalid_email7}
    ...    ${invalid_email8}
    Wait Until Element Is Visible    ${unq_billingInformation}
    Wait Until Keyword Succeeds    10s    1s    Input Text    ${inp_emailBillingInfo}    ${valid_email2}
    Wait Until Keyword Succeeds    10s    1s    Input Text    ${inp_phoneNumberBillingInfo}    ${valid_phoneNumber2}
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${box_sendAsGift}
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${box_checkboxTnC}
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_buyNow}
    ${logged_in}    Check Log In
    IF    not $logged_in
        Wait Until Element Is Visible    ${unq_loginCheckoutModal}
        Sleep    1s
        Click Element    ${btn_continueAsGuest}
    END
    Run Keyword And Continue On Failure    Wait Until Element Is Visible    ${err_emptyRecipientEmail}    timeout=5s
    Run Keyword And Continue On Failure    Click Element   ${err_emptyRecipientEmail}
    Run Keyword And Continue On Failure    Element Should Be Visible    ${err_invalidRecipientEmail}
    FOR    ${email}    IN    @{emails}
        Wait Until Keyword Succeeds    10s    1s    Input Text    ${inp_recipientEmail}    ${email}
        Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_buyNow}
         ${logged_in}    Check Log In
        IF    not $logged_in
            Wait Until Element Is Visible    ${unq_loginCheckoutModal}
            Sleep    1s
            Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_continueAsGuest}
        END
        Run Keyword And Continue On Failure    Wait Until Element Is Visible    ${err_emptyRecipientEmail}    timeout=5s
        Run Keyword And Continue On Failure    Click Element    ${err_emptyRecipientEmail}
        Run Keyword And Continue On Failure    Element Should Be Visible    ${err_invalidRecipientEmail}
    END

Check If User is Already Logged In
    [Documentation]    Check whether current user is logged in or not.
    ${before}    Get Selenium Implicit Wait
    Set Selenium Implicit Wait    1s
    ${already_login}    Run Keyword And Return Status    Element Should Be Visible    ${drd_myAccountsTop}
    Set Selenium Implicit Wait    ${before}
    IF    not $already_login
        Log in Through Modal in Checkout
    END
# ====================================================================================================