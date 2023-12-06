# ====================================================================================================
*** Settings ***
Documentation    Resources management for *CHECKOUT* test suite.
...
...
...                                    ...|GLOSSARY|...
...    btn = Clickable element or a button.
...    unq = Unique element of a page. Usually used to verify page/section or something similiar.
...    inp = Editable element or an input.
...    err = Element that represent error like erorr message, red alert icon, etc.
...    img = Element in picture format like svg, img or etc.
...    txt = Element that is a text whether it is inside or in text format like H1, H2, etc.
...    drd = Element that represent dropdown selection, section or something similiar.
...    opt = Element that represent an option from dropdown, radio button or something similiar.
...    box = Elemeent that represent checkbox or multiple selection.
Resource    ../Resources/imports.resource
# ====================================================================================================



# ====================================================================================================
*** Variables ***
# Checkout Page
${btn_buyGarenaShells70TW}    //button[@id='garena-shell-70-button' or @id='garena-shells-70-button' or @id='update-slug-denom-garena-button']
${unq_garenaShells70TW}    //h2[normalize-space()='Garena Shells 70']
${unq_garenaShells70TWCard}    //h4[normalize-space()='Garena Shells 70']
${btn_buyGarenaShells33ID}    //button[@id='garena-shell-33-button' or @id='garena-shells-33-button']
${unq_garenaShells33ID}    //h2[normalize-space()='Garena Shells 33 Voucher']
${unq_garenaShells33IDCard}    //h4[normalize-space()='Garena Shells 33 Voucher']
${btn_buyLineageGem300TW}    //button[@id='lineage-m-blue-gems-ntd-300-button']
${unq_lineageGem300TW}    //h2[normalize-space()='Lineage M Blue Gem NTD 300']
${unq_lineageGem300TWCard}    //h4[normalize-space()='Lineage M Blue Gem NTD 300']
${btn_buyMLDiamonds278TW}    //button[@id='mobile-legends-278-diamonds-button']
${unq_MLDiamonds278TW}    //h2[normalize-space()='Mobile Legends 278 Diamonds (Direct)' or normalize-space()='278 Mobile Legends Diamonds (Direct Top Up)']
${unq_MLDiamonds278TWCard}    //h4[normalize-space()='Mobile Legends 278 Diamonds (Direct)' or normalize-space()='278 Mobile Legends Diamonds (Direct Top Up)']
${btn_updateNowPhoneNumber}    //div[@id='phone-verification-required-section']//button[contains(@type,'button')]
${btn_terms&conditionCheckout}    //a[normalize-space()='Terms & Condition']
${btn_terms&conditionCheckout2}    //a[@class='a-tag-btn link'][contains(.,'Terms & Conditions')]    # Production
${btn_showMoreCheckout}    //p[normalize-space()='[Show more]']
${txt_showMoreDescription}    //p[@id='description-text'][@class='text']
${btn_showLessCheckout}    //p[normalize-space()='[Show less]']
${txt_showLessDescription}    //p[@id='description-text'][@class='text show-more-height']
${unq_step1Checkout}    //h2[normalize-space()='Step 1 - Select Denomination']
${unq_step2Checkout}    //h2[normalize-space()='Step 2 - Select Payment Method']
${unq_step3Checkout}    //h2[normalize-space()='Step 3 - Billing Information']
${inp_userIdCheckout}    name:userid
${inp_zoneIdCheckout}    name:zoneid
${btn_verifyZoneUserId}    //button[@id='verify-product-info']
${unq_userZoneIdFound}    //span[@class='text-success']

# Denomination
${btn_denom33}    //button[contains(@class,'button-denomination')]/span[text()='33']
${btn_denom33Active}    //button[contains(@class,'button-denomination-active')]/span[text()='33']
${btn_denom70}    //button[contains(@class,'button-denomination')]/span[text()='70']
${btn_denom70Active}    //button[contains(@class,'button-denomination-active')]/span[text()='70']
${btn_denom140}    //button[contains(@class,'button-denomination')]/span[text()='140']
${btn_denom140Active}    //button[contains(@class,'button-denomination-active')]/span[text()='140']
${btn_denom278}    //button[contains(@class,'button-denomination')]/span[text()='278']
${btn_denom278Active}    //button[contains(@class,'button-denomination-active')]/span[text()='278']
${btn_denom300}    //button[contains(@class,'button-denomination')]/span[text()='300']
${btn_denom300Active}    //button[contains(@class,'button-denomination-active')]/span[text()='300']
${btn_denom350}    //button[contains(@class,'button-denomination')]/span[text()='350']
${btn_denom350Active}    //button[contains(@class,'button-denomination-active')]/span[text()='350']
${btn_denom700}    //button[contains(@class,'button-denomination')]/span[text()='700']
${btn_denom700Active}    //button[contains(@class,'button-denomination-active')]/span[text()='700']
${btn_denom1400}    //button[contains(@class,'button-denomination')]/span[text()='1400']
${btn_denom1400Active}    //button[contains(@class,'button-denomination-active')]/span[text()='1400']

# Payment Gateway
${btn_pgwWildCardsActive}    //button[contains(@class,'payment-active')]
${btn_pPointsPGW}    //button/img[@title='P Points']
${btn_pgwFET}    //button/img[@title='FET']
${btn_pgwFETActive}    //button[contains(@class,'payment-active')]/img[@title='FET']
${btn_pgw7Eleven}    //button/img[@title='7-Eleven']
${btn_pgw7ElevenActive}    //button[contains(@class,'payment-active')]/img[@title='7-Eleven']
${btn_pgwFamilyMarket}    //button/img[@title='Family Mart']
${btn_pgwFamilyMarketActive}    //button[contains(@class,'payment-active')]/img[@title='Family Mart']
${btn_pgwVirtualATM}    //button/img[@title='Virtual ATM']
${btn_pgwVirtualATMActive}    //button[contains(@class,'payment-active')]/img[@title='Virtual ATM']
${btn_pgwTaiwanMobile}    //button/img[@title='Taiwan Mobile']
${btn_pgwTaiwanMobileActive}    //button[contains(@class,'payment-active')]/img[@title='Taiwan Mobile']
${btn_pgwChungHwa}    //button/img[@title='ChungHwa Telecom']
${btn_pgwChungHwaActive}    //button[contains(@class,'payment-active')]/img[@title='ChungHwa Telecom']
${btn_pgwAPT}    //button/img[@title='APT']
${btn_pgwAPTActive}    //button[contains(@class,'payment-active')]/img[@title='APT']
${btn_pgwUnionPay}    //button/img[@title='Union Pay']
${btn_pgwUnionPayActive}    //button[contains(@class,'payment-active')]/img[@title='Union Pay']
${btn_pgwCreditCard}    //button/img[@title='Credit Card']
${btn_pgwCreditCardActive}    //button[contains(@class,'payment-active')]/img[@title='Credit Card']
${btn_pgwPPointsDisabled}    //button[contains(@class,'disabled-payment')]/img[@src="https://walletcodes-92f3.kxcdn.com/img/telcos/PaymentGateway_ppoints.svg"]


# Order Summary
${txt_selectedProduct}    //body[1]/div[1]/main[1]/div[1]/div[1]/div[1]/section[1]/div[1]/div[1]/div[1]/div[3]/div[1]/div[1]/div[1]/table[1]/tbody[1]/tr[1]/td[1]
${txt_selectedPaymentMethod}    //body[1]/div[1]/main[1]/div[1]/div[1]/div[1]/section[1]/div[1]/div[1]/div[1]/div[3]/div[1]/div[1]/div[1]/table[1]/tbody[1]/tr[2]/td[1]
${txt_subtotal}    //body[1]/div[1]/main[1]/div[1]/div[1]/div[1]/section[1]/div[1]/div[1]/div[1]/div[3]/div[1]/div[1]/div[1]/table[1]/tbody[1]/tr[3]/td[1]
${txt_total}    //body[1]/div[1]/main[1]/div[1]/div[1]/div[1]/section[1]/div[1]/div[1]/div[1]/div[3]/div[1]/div[1]/div[1]/table[2]/tbody[1]/tr[1]/td[1]
${txt_pPointsToEarn}    //td[contains(@class,'rewards')]
${btn_buyNow}    //button[@id='buy-Now-web']

# Transaction
${unq_billingInformation}    //h2[normalize-space()='Step 3 - Billing Information']
${unq_billingInformation2}    //h2[normalize-space()='Last Step - Billing Information']    # Production
${inp_emailBillingInfo}    name:email
${inp_phoneNumberBillingInfo}    name:phonenumber
${box_checkboxTnC}    //input[@id='tnc-check']

# Send as Gift
${box_sendAsGift}    //span[@class='check cursor-pointer']
${inp_recipientEmail}    //input[@id='gift-card']

# Error Message
${err_loginBeforeCheckout}    //h2[normalize-space()='Login first to use this payment method' or normalize-space()='Login First to use this Payment Method']
${err_verifyPhoneNumberCheckout}    //h2[normalize-space()='Please verify your mobile number' or normalize-space()='Please Verify Your Mobile Number']
${err_uncheckTnC}    //div[@role='alert'][contains(text(),'Please agree to the Terms and Conditions to proceed')]
${err_emptyRecipientEmail}    //div[@role='alert'][contains(text(),'Email address is required') or contains(text(),'Recipient email is required')]
${err_invalidRecipientEmail}    //span[@class='text-warning'][contains(text(),'Enter a valid email address') or contains(text(),'Length of email should be 6-60 character')]
${err_failedProcessingPayment}    //div[@role='alert'][contains(text(),'An error occurred while processing payment')]
${err_unexpectedErrorInCheckout}    //h2[normalize-space()='Unexpected Error!']
${err_zoneIdRequired}    //div[@role='alert'][contains(text(),'zoneid is required')]
${err_userIdRequired}    //div[@role='alert'][contains(text(),'zoneid is required')]
${err_userZoneIdNotFound}    //form[@id='dynamic-product-field']//span[@class='text-danger']

# Login Modal
${btn_loginCheckout}    //button[@id='login-btn']
${btn_registerCheckout}    //button[@id='register-btn']
${unq_loginCheckoutModal}    //h1[normalize-space()='1 STEP AWAY COLLECTING YOUR P POINTS']
${inp_emailLoginCheckout}    //input[@id='email']
${inp_passwordLoginCheckout}    //input[@id='password']
${btn_submitLoginCheckout}    //button[@id='login-modal-button']
${btn_whatIsPpointLoginCheckout}    //a[@target='blank'][normalize-space()='What is P Point?']
${btn_forgotPasswordLoginCheckout}    //a[normalize-space()='Forget Password?']
${btn_registerLoginModal}    //button[@class='a-tag-btn link text-capitalize'][normalize-space()='Register']
${btn_continueAsGuest}    //button[@id='continue-as-guest']

# Register Modal
${unq_registerCheckoutModal}    //h1[normalize-space()='SEAMLESSLY COLLECT YOUR P POINTS!']
${inp_nameRegisterCheckout}    name:name
${inp_emailRegisterCheckout}    name:email
${inp_passwordRegisterCheckout}    name:password
${inp_phoneNumberRegisterCheckout}    name:phonenumber
${inp_DOBRegisterCheckout}    name:birthdate
${btn_submitRegisterCheckout}    //button[@id='register-button']
${btn_loginRegisterModal}    //button[@class='a-tag-btn link text-capitalize'][text()='Login']
${btn_whatIsPpointLoginCheckout}    //a[normalize-space()='What is P Point?']

# So Net Gateway
${inp_recipientNameSonet}    //input[@id='userName']
${inp_recipientEmailSonet}    //input[@id='email']
${btn_agreeSonet}    //input[@id='agreeBtn']
${btn_disagreeSonet}    //input[@id='cancelBtn']
${unq_FamilyMarketSonet}    //td[contains(text(),'Family Market 超商代收')]
${unq_VirtualATMSonet}    //td[contains(text(),'第一銀行虛擬ATM')]
${unq_APTSonet}    //td[contains(text(),'亞太電信小額付款')]
${unq_unionPayCCSonet}    //td[contains(text(),'So-net信用卡金流服務')]
${inp_ccNumber1Sonet}    //input[@id='panNo1']
${inp_ccNumber2Sonet}    //input[@id='panNo2']
${inp_ccNumber3Sonet}    //input[@id='panNo3']
${inp_ccNumber4Sonet}    //input[@id='panNo4']
${inp_cvcSonet}    //input[@id='cvc2']
${drd_expireMonthSonet}    //select[@name='expireMonth']
${opt_decemberMonthSonet}    //option[@value='12']
${drd_expireYearSonet}    //select[@name='expireYear']
${opt_2038YearSonet}    //option[@value='2038']
${btn_submitCCSonet}    //input[@id='btnSubmit']
${unq_VirtualATMSonetOTP}    //td[contains(text(),'．請輸入您手機接收到的單次使用認證密碼：')]

# Secure Pay Gateway
${unq_ccSecurePay}    //h4[normalize-space()='Pay with Credit or Debit Card']
${inp_cardholderSecurePay}    //input[@id='param4']
${inp_cardNumber1SecurePay}    //input[@id='cardnumber1']
${inp_cardNumber2SecurePay}    //input[@id='cardnumber2']
${inp_cardNumber3SecurePay}    //input[@id='cardnumber3']
${inp_cardNumber4SecurePay}    //input[@id='cardnumber4']
${drd_expireMonthSecurePay}    //select[@id='epMonth2']
${opt_decemberMonthSecurePay}    //option[@value='12']
${drd_expireMonthSecurePay}    //select[@id='epYear2']
${opt_2037YearSecurePay}    //option[@value='2037']
${inp_cvvSecurePay}    //input[@id='cvv2']
${btn_submitCCSecurePay}    //button[@id='postNow']
${unq_failedPaymentSecurePay}    //h1[normalize-space()='Ooopsss!']
${btn_returnToWalletCodes}    //a[@id='btnReturn']
${btn_cancelPaymentSecurePay}    //a[@id='acancel']

# Thank You Page
${unq_thankyouPage}    //h2[normalize-space()='Thank You']
${txt_transactionIDTYPage}    //body[1]/div[1]/main[1]/div[1]/section[1]/div[2]/div[1]/div[1]/div[2]/div[1]/table[1]/tbody[1]/tr[1]/td[2]
${txt_productTYPage}    //body[1]/div[1]/main[1]/div[1]/section[1]/div[2]/div[1]/div[1]/div[2]/div[1]/table[1]/tbody[1]/tr[2]/td[2]
${txt_paymentMethodTYPage}    //body[1]/div[1]/main[1]/div[1]/section[1]/div[2]/div[1]/div[1]/div[2]/div[1]/table[1]/tbody[1]/tr[3]/td[2]
${txt_paymentStatusTYPage}    //body[1]/div[1]/main[1]/div[1]/section[1]/div[2]/div[1]/div[1]/div[2]/div[1]/table[1]/tbody[1]/tr[4]/td[2]
${txt_dateTYPage}    //body[1]/div[1]/main[1]/div[1]/section[1]/div[2]/div[1]/div[1]/div[2]/div[1]/table[1]/tbody[1]/tr[5]/td[2]
${txt_totalTYPage}    //body[1]/div[1]/main[1]/div[1]/section[1]/div[2]/div[1]/div[1]/div[2]/div[1]/table[2]/tbody[1]/tr[1]/td[2]
${btn_contactSupportTYPage}    //button[@class='wc-btn-secondary m-2']/span[contains(text(),'Contact Support')]
${btn_shopMoreTYPage}    //button[@class='wc-btn-primary m-2']/span[contains(text(),'Shop More')]
${unq_successPayment}    //h1[normalize-space()='Payment Success']
${btn_redeemTYPage}    //button[@class='wc-btn-secondary m-2']/span[contains(text(),'Redeem')]
${unq_pendingPayment}    //h1[normalize-space()='Payment Pending']
# ====================================================================================================



# ====================================================================================================
*** Keywords ***
Select Payment Method
    [Documentation]    Select payment method in checkout page. Available payment methods: FET,
    ...                Union Pay, CC and Virtual ATM.
    [Arguments]    ${payment}
    IF    $checkTaiwan in $url_usedUrl
        Scroll Element Into View    ${unq_step1Checkout}
    ELSE
        Scroll Element Into View    ${unq_garenaShells33ID}    
    END
    IF    $payment == 'FET'
        Wait Until Element Is Visible    ${btn_pgwFET}
        Click Element    ${btn_pgwFET}
        Element Should Be Visible    ${btn_pgwFETActive}
    ELSE IF    $payment == 'Union Pay'
        Wait Until Element Is Visible    ${btn_pgwUnionPay}
        Click Element    ${btn_pgwUnionPay}
        Element Should Be Visible    ${btn_pgwUnionPayActive}
    ELSE IF    $payment == "CC"
        Wait Until Element Is Visible    ${btn_pgwCreditCard}
        Click Element    ${btn_pgwCreditCard}
        Element Should Be Visible    ${btn_pgwCreditCardActive}
    ELSE IF    $payment == "Virtual ATM"
        Wait Until Element Is Visible    ${btn_pgwVirtualATM}
        Click Element    ${btn_pgwVirtualATM}
        Element Should Be Visible    ${btn_pgwVirtualATMActive}
    END

Verify Show More Product Description
    [Documentation]    Assertion for showing more description text of a product in checkout page.
    Wait Until Element Is Visible    ${btn_showMoreCheckout}
    Scroll Element Into View    ${btn_showMoreCheckout}
    Click Element    ${btn_showMoreCheckout}
    Run Keyword And Continue On Failure    Element Should Be Visible    ${txt_showMoreDescription}

Verify Show Less Product Description
    [Documentation]    Assertion for showing less description text of a product in checkout page.
    Wait Until Element Is Visible    ${btn_showLessCheckout}
    Scroll Element Into View    ${btn_showLessCheckout}
    Click Element    ${btn_showLessCheckout}
    Run Keyword And Continue On Failure    Element Should Be Visible    ${txt_showLessDescription}

Verify T&C Before Checkout
    [Documentation]    Assertion for term and condition CTA in checkout page.
    IF    $checkStaging in $url_usedUrl or $checkPreprod in $url_usedUrl
        Wait Until Element Is Visible    ${btn_terms&conditionCheckout}
        Scroll Element Into View    ${btn_terms&conditionCheckout}
        Click Element    ${btn_terms&conditionCheckout}
    ELSE
        Wait Until Element Is Visible    ${btn_terms&conditionCheckout2}
        Scroll Element Into View    ${btn_terms&conditionCheckout2}
        Click Element    ${btn_terms&conditionCheckout2}
    END
    Run Keyword And Continue On Failure    Wait Until Element Is Visible    ${unq_t&cPage}    10s
# ====================================================================================================