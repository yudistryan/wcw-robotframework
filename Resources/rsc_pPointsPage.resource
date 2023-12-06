# ====================================================================================================
*** Settings ***
Documentation    Resources management for *P POINTS* test suite.
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
# Redeem P Points
${inp_promoCode}    //input[@id='form']
${btn_redeemCode}    //button[normalize-space()='REDEEM']
${err_invalidPromoCode}    //div[@role='alert'][text()='Voucher Code is Invalid']
${err_invalidPromoCodeTW}    //div[@role='alert'][text()='Voucher Code is Invalid.']
${btn_whatIsPpointRedeemPoint}    //a[normalize-space()='Learn more about P Points?']

# P Point History
${unq_emptyPPointHistory}    //img[@src="https://walletcodes-92f3.kxcdn.com/img/assets/utils/no-files.svg"]
${btn_browseProductPPointHistory}    //button[normalize-space()='Browse Products']
${txt_pPointsBalancePPointHistory}    /html[1]/body[1]/div[1]/main[1]/div[1]/section[1]/div[1]/div[1]/div[2]/div[1]/h2[2]
${txt_datePPointHistoryHeader}    //th[normalize-space()='DATE']
${txt_typePPointHistoryHeader}    //th[normalize-space()='Transaction Type']
${txt_pointPPointHistoryHeader}    //th[normalize-space()='P POINTS']
${txt_row1DatePntHistory}    //body[1]/div[1]/main[1]/div[1]/section[1]/div[1]/div[1]/div[2]/div[2]/table[1]/tbody[1]/tr[1]/td[1]    # 1st row
${txt_row1TypePntHistory}    //body[1]/div[1]/main[1]/div[1]/section[1]/div[1]/div[1]/div[2]/div[2]/table[1]/tbody[1]/tr[1]/td[2]    # 1st row
${txt_row1PointPntHistory}    //body[1]/div[1]/main[1]/div[1]/section[1]/div[1]/div[1]/div[2]/div[2]/table[1]/tbody[1]/tr[1]/td[3]    # 1st row
${txt_pPointsBalance}    //h2[@class='col-6 text-right pb-2 follow-seo-h3-normal pts']

# Daily Rewards
${btn_whatIsTheBenefit}    //span[@class='benefit']
${btn_checkIn}    //button[@id='check-in-btn']

# URL
${checkMyPPointPage}    /user-profile/my-points
# ====================================================================================================



# ====================================================================================================
*** Keywords ***
My P Points Setup
    [Documentation]    P Points test suite setup before executing the test steps.
    [Arguments]    ${email}=${valid_email2}    ${password}=${valid_password}
    ${currentUrl}    Get Location
    IF    $checkMyPPointPage not in $currentUrl 
        Check If This is Taiwan Website
        Log in to Wallet Codes website    ${email}    ${password}    english=${False}
        Go to My P Points Page
    ELSE
        Reload Page
        Wait Until Element Is Visible    ${unq_redeemPPointPage}
    END

Go to My P Points Page
    [Documentation]    Go to my p points page. User must be logged in first, if not it will fail.
    IF    $checkTaiwan not in $url_usedUrl
        Mouse Over    ${drd_mypPointsTop}
    ELSE IF    $checkTaiwan in $url_usedUrl
        IF    $checkStaging in $url_usedUrl or $checkPreprod in $url_usedUrl
            Mouse Over    ${drd_myPointsTop}
        ELSE
            Mouse Over    ${drd_mypPointsTop}
        END
    END
    Click Element    ${opt_redeemHistory}
    Wait Until Element Is Visible    ${unq_redeemPPointPage}
# ====================================================================================================