# ====================================================================================================
*** Settings ***
Documentation    Global resources management for all test suites.
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
...    box = Element that represent checkbox or multiple selection.
Resource    ../Resources/imports.resource
# ====================================================================================================



# ====================================================================================================
*** Variables ***
#Homepage
${unq_homepage}    //h2[normalize-space()='P POINTS']
${unq_homepageTW}    //h2[contains(text(),'P點')]
${err_alertWildCard}    //div[@role='alert']
${btn_acceptAllCookies}    //button[@data-cky-tag='accept-button']

# Product Pages
${unq_steamIDPage}    //h2[normalize-space()='Steam Wallet Codes']
${unq_ucPubgPage}    //h2[normalize-space()='UC PUBG Mobile']
${unq_diamondMLPage}    //h2[normalize-space()='Mobile Legends Diamonds']
${unq_shellGarenaPage}    //h2[normalize-space()='Garena Shells']
${unq_pointblankPage}    //h2[normalize-space()='Point Blank']
${unq_ayodanceIDPage}    //h2[normalize-space()='Ayodance Indonesia']
${unq_googleplayGiftpage}    //h2[normalize-space()='Google Play Gift Card']
${unq_robloxIDPage}    //h2[normalize-space()='Roblox ID']    # Staging
${unq_robloxIDPage2}    //h2[normalize-space()='Roblox Gift Card']    # Preprod
${unq_robloxIDPageTW}    //h2[normalize-space()='Roblox Gift Cards (Robux)']    # Production
${unq_freefireIDPage}    //h2[normalize-space()='Free Fire ID']
${unq_lifeafterIDPage}    //h2[normalize-space()='LifeAfter ID']
${unq_testCodesPage}    //h2[normalize-space()='TEST CODES']
${unq_ragnarokBCCIDpage}    //h2[normalize-space()='Ragnarok BCC ID']
${unq_psnIDPage}    //h2[normalize-space()='PlayStationIDR ID']    # Staging
${unq_psnIDPage2}    //h2[normalize-space()='Playstation Network Cards']    # Preprod
${unq_ragnarokZennyPage}    //h2[normalize-space()='Ragnarok Zeny ID']
${unq_lordsmobilePage}    //h2[normalize-space()='Lords Mobile ID']
${unq_saintSeiyaIDpage}    //h2[normalize-space()='Saint Seiya ID']
${unq_lineageMBluePage}    //h2[normalize-space()='Lineage M Blue Gem']
   
# My Account
${unq_myProfilePage}    //h2[normalize-space()='My Profile']
${unq_transactionHistoryPage}    //h2[normalize-space()='Transaction History']

# Contact Us
${unq_contactUs}    //h1[normalize-space()='SEND US A MESSAGE']

# My P Points
${unq_dailyRewardPage}    //h2[normalize-space()='Daily Rewards']
${unq_redeemPPointPage}    //h1[normalize-space()='REDEEM P POINTS']
${unq_redeemPointPage}    //h1[normalize-space()='REDEEM POINTS']
${unq_titlePPointPage}    //div[@class='page-title']//h2[contains(text(),'My P Points')]
${unq_titlePointPage}    //div[@class='page-title']//h2[contains(text(),'My Points')]
${unq_pPointHistoryTitle}    //h2[@class='col-6 text-uppercase pb-2 follow-seo-h3-normal'][contains(text(),'My P Points')]
${unq_pointHistoryTitle}    //h2[@class='col-6 text-uppercase pb-2 follow-seo-h3-normal'][contains(text(),'My Points')]
${unq_crumbPPointHistory}    //li[@class='breadcrumb-item active text-danger'][contains(text(), 'My P Points')]
${unq_crumbPointHistory}    //li[@class='breadcrumb-item active text-danger'][contains(text(), 'My Points')]
${txt_pPointUnderPromoCode}    //b[normalize-space()='P Points']
${txt_pointUnderPromoCode}    //b[normalize-space()='Points']
${txt_emptyHistoryPPoint}    //strong[contains(text(),'Your P Points')]
${txt_emptyHistoryPoint}    //strong[contains(text(),'Your Points')]

# Registration Page
${unq_registrationPage}    //h1[normalize-space()='Create Account']
${unq_registrationPageTW}    //h1[normalize-space()='CREATING YOUR ACCOUNT...']

# Log in page
${unq_loginPage}    //h1[normalize-space()='login']
${unq_loginPage2}    //h1[normalize-space()='Login']

# Wallet Codes Experience
${unq_whyWalletCodes}    //h2[normalize-space()='Why Wallet Codes?']
${unq_whatIsPPoints}    //h2[normalize-space()='P Points']
${unq_whatIsDailyRewards}    //h2[normalize-space()='Daily Rewards']

# Support Pages
${unq_supportPage}    //h2[normalize-space()='SHOPPING WITH WALLET CODES']
${unq_t&cPage}    //h2[normalize-space()='Terms & Conditions']
${unq_privacyPolicyPage}    //h2[normalize-space()='Privacy Policy']
${unq_ppointsDefinitions}    //h2[normalize-space()='P Points']

# Footer
${unq_copyright}    //img[@title='copyright']
# ====================================================================================================



# ====================================================================================================
*** Keywords ***
Execution Settings
    [Documentation]    Set execution configuration. Available settings: execution speed, 
    ...                Selenium implicit wait and browser impilicit wait. 
    ...    
    ...                -> Speed is how long the delay between each steps. E.g: speed=1 it means it 
    ...                will have 1 second delay between each steps.
    ...                
    ...                -> Implicit wait is how long it takes for timeout. If you put in Selenium, it
    ...                will affect all test suites that's executing now. While for browser, it
    ...                will affect current opened browser.
    [Arguments]    ${speed}=0    ${implicit_wait}=0    ${browser_implicit_wait}=0
    Set Selenium Speed    ${speed}
    Set Selenium Implicit Wait    ${implicit_wait}
    Set Browser Implicit Wait    ${browser_implicit_wait}

Get Test Code
    [Documentation]    Return testrails code of current test.
    ${code}    Fetch From Left    ${TEST_NAME}    ${SPACE}
    RETURN    ${code}

Skip Blacklisted Test Cases
    [Documentation]    Setup for skip test cases that's stored in `${disabledTCs}`.
    ${TEST_CODE}    Get Test Code
    IF    $TEST_CODE in $disabledTCs
        Skip
    END

Go to Wallet Codes Website
    [Documentation]    Go to Wallet Codes testing environment. Parameters are $env and $browser which
    ...                you can provide the desired Wallet Codes environment and browser.
    ...                If the url is not Wallet Codes testing website it will fail. $env values are 'Staging', 
    ...                'Staging TW', 'Preprod', 'Preprod TW', 'Production' and 'Production TW'.
    ...                
    ...
    ...                Other options are $wait for Selenium implicit wait. If $video is True then it will be
    ...                record video for the whole test suite and you can set the resolution by inputting value
    ...                to $resolution.
    [Arguments]    ${env}    ${browser}    ${wait}=5    ${video}=False    ${resolution}=360px
    IF    $env == "Staging" 
        Set Global Variable    ${url_usedUrl}   ${url_baseID_staging}
    ELSE IF    $env == "Staging TW" 
        Set Global Variable    ${url_usedUrl}    ${url_baseTW_staging}
    ELSE IF    $env == "Preprod" 
        Set Global Variable    ${url_usedUrl}    ${url_baseID_preprod}
    ELSE IF    $env == "Preprod TW" 
        Set Global Variable    ${url_usedUrl}    ${url_baseTW_preprod}
    ELSE IF    $env == "Production" 
        Set Global Variable    ${url_usedUrl}    ${url_baseID_production}
    ELSE IF    $env == "Production TW" 
        Set Global Variable    ${url_usedUrl}    ${url_baseTW_production}
    END
    Open Browser    ${url_usedUrl}    ${browser}
    Set Selenium Implicit Wait    ${wait}
    IF    $video==True
        Start Video Recording    embed=${True}    embed_width=${resolution}
    END
    Maximize Browser Window
    IF    $checkTaiwan not in $url_usedUrl
        Wait Until Page Contains Element    ${unq_homepage}
    ELSE IF    $checkTaiwan in $url_usedUrl
        Close Modal Pop-up
        Wait Until Page Contains Element    ${unq_homepageTW}
        Change Language to English
    END
    Accept All Cookies

End Testing
    [Documentation]    End testing by closing current browser. If you put $video=True in 'Go to Wallet Codes
    ...                Website' keyword, you must put the same on this keyword as well.
    ...                If more than one browser are open, you need to use 'Close All Browser'
    ...                keyword instead.
    [Arguments]    ${video}=${False}    ${close_all}=${False}
    IF    $video
        Stop Video Recording    save_to_disk=${False}
    END
    IF    not $close_all
        Close Browser
    ELSE
        Close All Browsers
    END

Switch to Another Window
    [Documentation]    Switch to the last tab in current opened browser.
    ${handles}=    Get Window Handles
    Switch Window    ${handles}[-1]

Switch to Another Window and Get the URL
    [Documentation]    Switch to the last tab in current opened browser and return active tab URL.
    ${handles}=    Get Window Handles
    Switch Window    ${handles}[-1]
    ${currentUrl}    Get Location
    [Return]    ${currentUrl}

Change Language to English
    [Documentation]    Change website local language to English.
    ${before}    Get Selenium Implicit Wait
    Set Selenium Implicit Wait    1s
    Mouse Over    ${drd_language}
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${opt_englishWildCard}
    Sleep    0.25s
    Close Modal Pop-up
    Set Selenium Implicit Wait    ${before}

Check If English is Already Selected
    [Documentation]    Check whether website language is already in English or not.
    ${before}    Get Selenium Implicit Wait
    Set Selenium Implicit Wait    1s
    ${already_english}    Run Keyword And Return Status    Page Should Contain Element    ${opt_englishWildCardSelected}
    Set Selenium Implicit Wait    ${before}
    IF    not $already_english
        Mouse Over    ${drd_language}
        Wait Until Keyword Succeeds    10s    1s    Click Element    ${opt_englishWildCard}
        Sleep    0.25s
        Close Modal Pop-up
    END

Log in to Wallet Codes website
    [Documentation]    Logging in to Wallet Code website. Make sure to input valid email and password.
    ...                If $english is True then before log in, it will change the language into English
    ...                before proceeding.
    [Arguments]    ${email}=${valid_email2}    ${password}=${valid_password}    ${english}=${True}
    IF    $english
        Change Language to English       
    END
    IF    $checkTaiwan not in $url_usedUrl
        IF    $checkStaging in $url_usedUrl or $checkPreprod in $url_usedUrl
            Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_loginTop}
            Wait Until Element Is Visible    ${unq_loginPage}
        ELSE
            Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_loginTop2}
            Wait Until Element Is Visible    ${unq_loginPage2}
        END
    ELSE IF    $checkTaiwan in $url_usedUrl
        IF    $checkStaging in $url_usedUrl or $checkPreprod in $url_usedUrl
            Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_loginTop}
            Wait Until Element Is Visible    ${unq_loginPage2}
        ELSE
            Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_loginTop}
            Wait Until Element Is Visible    ${unq_loginPage}
        END
    END
    Wait Until Keyword Succeeds    10s    1s    Input Text    ${inp_emailLogin}    ${email}
    Wait Until Keyword Succeeds    10s    1s    Input Password    ${inp_passwordLogin}    ${password}
    #You need to verify the recaptcha V3
    Execute Manual Step    Please bypass the recaptcha
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_submitLogin}
    Wait Until Element Is Visible    ${unq_loggedIn}    timeout=30s
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${unq_loggedIn}
    Close Modal Pop-up

Clear Form Input
    [Documentation]    Alternative keyword for "Clear Element Text". Some input fields are not really
    ...                remove all text inside an input field. Using this keyword might help.
    [Arguments]    ${locators}
    Wait Until Keyword Succeeds    10s    1s    Press Keys    ${locators}    CTRL+A    DELETE

Change Country Base
    [Documentation]    Change Wallet Codes website country base. Provide desired country from this list: 
    ...
    ...                -> Malaysia
    ...
    ...                -> Indonesia
    ...
    ...                -> Thailand
    ...    
    ...                -> Myanmar
    ...    
    ...                -> Phillippines
    ...    
    ...                -> Taiwan
    [Arguments]    ${country}    
    Mouse Over    ${drd_countriesList}
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${drd_countriesList}
    IF    $country == "Malaysia"
        Wait Until Keyword Succeeds    10s    1s    Click Element    ${opt_countryMY}
        IF    $checkStaging not in $url_usedUrl and $checkPreprod not in $url_usedUrl
            Wait Until Page Contains Element    ${unq_paymentMethodsMY2}
        ELSE
            Wait Until Page Contains Element    ${unq_paymentMethodsMY}
        END
    ELSE IF    $country == "Indonesia"
        Wait Until Keyword Succeeds    10s    1s    Click Element    ${opt_countryID}
        Wait Until Page Contains Element    ${unq_paymentMethodsID}
    ELSE IF    $country == "Thailand"
        Wait Until Keyword Succeeds    10s    1s    Click Element    ${opt_countryTH}
        Wait Until Page Contains Element    ${unq_paymentMethodsTH}
    ELSE IF    $country == "Myanmar"
        Wait Until Keyword Succeeds    10s    1s    Click Element    ${opt_countryMM}
        Wait Until Page Contains Element    ${unq_paymentMethodsMM}
    ELSE IF    $country == "Phillippines"
        Wait Until Keyword Succeeds    10s    1s    Click Element    ${opt_countryPH}
        Wait Until Page Contains Element    ${unq_paymentMethodsPH}
    ELSE IF    $country == "Taiwan"
        Wait Until Keyword Succeeds    10s    1s    Click Element    ${opt_countryTW}
        Wait Until Page Contains Element    ${unq_homepageTW}
    END

Verify if Elements are Visible
    [Documentation]    Assertion for one or more elements whether it's visible in current page or not. 
    ...                Element can be a list or scalar and timeout is in seconds.
    [Arguments]    @{elements}    ${timeout}=3s
    ${before}    Get Selenium Implicit Wait
    Set Selenium Implicit Wait    ${timeout}
    FOR    ${element}    IN    @{elements}
        Run Keyword And Continue On Failure    Element Should Be Visible    ${element}
    END

Close Modal Pop-up
    [Documentation]    Closing modal that's popped up upon user going to homepage. This only happen
    ...                on Taiwan Production website.
    IF    $checkStaging not in $url_usedUrl and $checkPreprod not in $url_usedUrl and $checkTaiwan in $url_usedUrl
        ${popup}    Run Keyword And Return Status    Wait Until Element Is Visible    ${btn_closePopUpTW}    3s
        IF    $popup
            Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_closePopUpTW}
        END 
    END

Check For Unexpected Error
    [Documentation]    Check for unidentified error from alert that showed up.
    ${before}    Get Selenium Implicit Wait
    Set Selenium Implicit Wait    1s
    ${unexpected_error}    Run Keyword And Return Status    Element Should Be Visible    ${err_alertWildCard}
    IF    $unexpected_error
        Wait Until Keyword Succeeds    10s    1s    Click Element    ${err_alertWildCard}
    END
    Set Selenium Implicit Wait    ${before}

Check If This is Taiwan Website
    [Documentation]    Check if current website is Wallet Codes Taiwan website.
    ${before}    Get Selenium Implicit Wait
    Set Selenium Implicit Wait    1s
    Check For Unexpected Error
    ${already_english}    Run Keyword And Return Status    Page Should Contain Element    ${opt_englishWildCardSelected}
    IF    $checkTaiwan not in $url_usedUrl and not $already_english
        Change Language to English
    END
    Set Selenium Implicit Wait    ${before}

Skip If This is not Taiwan Website
    [Documentation]    Skip the test case if current website is not Wallet Codes Taiwan website.
    Skip If    $checkTaiwan not in $url_usedUrl

Skip If This is Taiwan Website
    [Documentation]    Skip the test case if current website is Wallet Codes Taiwan website.
    Skip If    $checkTaiwan in $url_usedUrl

Skip If This is Staging Website
    [Documentation]    Skip the test case if current test environment is Staging.
    Skip If    $checkStaging in $url_usedUrl

Skip If This is Preprod Website
    [Documentation]    Skip the test case if current test environment is Pre-Production.
    Skip If    $checkPreprod in $url_usedUrl

Skip If This is Production Website
    [Documentation]    Skip the test case if current test environment is Production.
    Skip If    $checkStaging not in $url_usedUrl and $checkPreprod not in $url_usedUrl

Check Log In
    [Documentation]    Check if current user is already logged in or not, return the status in boolean.
    ${before}    Get Selenium Implicit Wait
    Set Selenium Implicit Wait    1s
    ${logged_in}    Run Keyword And Return Status    Element Should Be Visible    ${drd_myAccountsTop}
    Set Selenium Implicit Wait    ${before}
    RETURN    ${logged_in}

Accept All Cookies
    [Documentation]    Click accept all cookies in cookies banner upon first time visit the website.
    ${before}    Get Selenium Implicit Wait
    Set Selenium Implicit Wait    1s
    ${cookies}    Run Keyword And Return Status    Wait Until Element Is Visible    ${btn_acceptAllCookies}    2s 
    IF    $cookies
        Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_acceptAllCookies}
    END
    Set Selenium Implicit Wait    ${before}
# ====================================================================================================