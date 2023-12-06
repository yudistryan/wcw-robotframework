# ====================================================================================================
*** Settings ***
Documentation    Homepage functionalities and UI conformation.
...              
...              Test Environment: *${global_env}*
Resource    ../Resources/imports.resource
Test Tags    Regression
Suite Setup    Go to Wallet Codes Website    ${global_env}    chrome
Suite Teardown    End Testing
# ====================================================================================================



# ====================================================================================================
*** Variables ***
# ====================================================================================================



# ====================================================================================================
*** Test Cases ***
C9970 Banner functionalities
    [Documentation]    Banner functionalities in Homepage, including navigation and redirection, etc.
    [Tags]    Staging    Preprod    Production    Global    Taiwan
    Homepage Setup
    Change to Malaysia Website If Not in Taiwan
    Click on Next Banner
    Click on Previous Banner
    Back to Indonesia's Website If Not In Taiwan

C9971 Top selling functionalities
    [Documentation]    Top Selling functionalities in Homepage, including redirection, etc.
    [Tags]    Staging    Preprod    Production    Global    Taiwan
    IF    $checkStaging in $url_usedUrl and $checkTaiwan not in $url_usedUrl
        Homepage Setup
        Verify PUBG in Top Selling Section
        Go Back to Homepage
        Verify PB in Top Selling Section
    ELSE IF    $checkStaging not in $url_usedUrl and $checkPreprod not in $url_usedUrl and $checkTaiwan in $url_usedUrl
        Homepage Setup
        Verify Garena Shell in Top Selling Section
    ELSE IF    $checkTaiwan in $url_usedUrl
        Homepage Setup
        Verify Mobile Legends in Top Selling Section
    ELSE
        Pass Execution    There's no Top Selling in Pre-Production
    END

C9972 Products/categories functionalities
    [Documentation]    Product/Categories functionalities in Homepage, including redirection, etc.
    [Tags]    Staging    Preprod    Production    Global    Taiwan
    IF    $checkStaging in $url_usedUrl and $checkTaiwan not in $url_usedUrl
        Homepage Setup
        Verify Steam ID Product
        Go Back to Homepage
        Verify Google Play Gift Card ID Product
        Go Back to Homepage
        Verify Life After ID Product
        Go Back to Homepage
        Verify Saint Seiya ID Product
    ELSE IF    $checkTaiwan not in $url_usedUrl  
        Homepage Setup
        Verify Steam ID Product
        Go Back to Homepage  
        Verify Google Play Gift Card ID Product For Preprod and Prod
        Go Back to Homepage
        Verify Life After ID Product For Preprod and Prod
        Go Back to Homepage
        Verify Saint Seiya ID Product For Preprod and Prod
    ELSE IF    $checkTaiwan in $url_usedUrl 
        IF    $checkStaging in $url_usedUrl
            Homepage Setup
            Verify Google Play Gift Card TW Product
            Go Back to Homepage
            Verify Garena Shells TW Product
            Go Back to Homepage
            Verify Mobile Legends TW Product
        ELSE 
            Homepage Setup
            Verify Google Play Gift Card TW Product For Preprod and Prod
            Go Back to Homepage
            Verify Garena Shells TW Product For Preprod and Prod
            Go Back to Homepage
            Verify Mobile Legends TW Product For Preprod and Prod
        END 
    END

C9973 Wallet codes experience redirection
    [Documentation]    Wallet Codes Experience section functionalities in Homepage, including redirection, etc.
    [Tags]    Staging    Preprod    Production    Global    Taiwan
    Homepage Setup
    Close Modal Pop-up
    Verify Why Wallet Codes CTA
    Go Back to Homepage
    Verify What is P Point CTA
    Go Back to Homepage
    Verify Daily Rewards Definition CTA

C9974 P points section redirection
    [Documentation]    P Points section functionalities in Homepage, including redirection, etc.
    [Tags]    Staging    Preprod    Production    Global    Taiwan
    Homepage Setup
    Verify Learn About P Points

C9976 Homepage UI conformation
    [Documentation]    Homepage UI confirmation for elements that should be there.
    [Tags]    Staging    Preprod    Production    Global    Taiwan
    # Top Main Menu Validation - Logged In
    Homepage Setup
    Check If User Has Been Logged In
    Verify My P Points and My Accounts Menu

    # Top Sub Menu Validation - Logged In
    Verify My P Points and My Accounts Submenu

    # Top Main Menu Validation - Not Logged In
    Check Log Out
    Verify Top Menu Elements

    # Top Sub Menu Validation - Not Logged In
    Verify Contact Us Menu and Submenu
    Verify Products Menu and Submenu
    Verify Language Menu and Submenu
    
    # Top Selling
    Verify Top Selling Section

    # Category
    Verify Product/Categories Section

    # Wallet Codes Experience
    Verify Wallet Codes Experience Section

    # Payment Methods
    Verify Available Payment Methods

    #P Points
    Verify About P Points

    # Footer - Left Section (Socmed)
    Verify Footer Social Media

    # Footer - Left Section (Country Selection)
    Verify Footer Countries

    # Footer - Middle Section (Quick Links)
    Verify Footer Quick Links

    # Footer - Middle Section (Support)
    Verify Footer Support

    # Footer - Middle Section (Awards)
    Verify Footer Awards

    # Footer - Right Section
    Verify Footer Google Play CTA
# ====================================================================================================



# ====================================================================================================
*** Keywords ***
Homepage Setup
    [Documentation]    Configuration before executing test steps in Homepage suite.
    ${before}    Get Selenium Implicit Wait
    Set Selenium Implicit Wait    1s
    ${homepage}    Run Keyword And Return Status    Element Should Be Visible    ${unq_bannerActive}
    Set Selenium Implicit Wait    ${before}
    IF    not $homepage
        Wait Until Keyword Succeeds    10s    1s    Click Element    ${img_logoTop}
        Wait Until Element Is Visible    ${unq_bannerActive}
        Close Modal Pop-up
    ELSE
        Close Modal Pop-up
    END
    Check If This is Taiwan Website

Go Back to Homepage
    [Documentation]    Redirect user to homepage by clicking Wallet Codes logo on top menu bar.
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${img_logoTop}
    IF    $checkTaiwan not in $url_usedUrl
        Wait Until Page Contains Element    ${unq_homepage}
    ELSE IF     $checkTaiwan in $url_usedUrl
        IF    $checkStaging in $url_usedUrl or $checkPreprod in $url_usedUrl
            Wait Until Page Contains Element    ${unq_homepageTWEnglish}
        ELSE IF    $checkStaging not in $url_usedUrl and $checkPreprod not in $url_usedUrl
            Close Modal Pop-up
            Wait Until Page Contains Element    ${unq_homepage}
        END
    END
    
Change to Malaysia Website If Not in Taiwan
    [Documentation]    Change website country base to Malaysia if current site is Taiwan.
    IF    $checkStaging not in $url_usedUrl and $checkPreprod not in $url_usedUrl and $checkTaiwan not in $url_usedUrl
        Change Country Base    Malaysia
    END

Click on Next Banner
    [Documentation]    Click on right nav button in banner.
    Wait Until Element Is Visible    ${unq_bannerActive}
    Mouse Over    ${unq_bannerActive}
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_nextButton}
    Element Should Be Visible    ${unq_secondBannerActive}

Click on Previous Banner
    [Documentation]    Click on left nav button in banner.
    Wait Until Element Is Visible    ${unq_bannerActive}
    Mouse Over    ${unq_bannerActive}
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_previousButton}
    Element Should Be Visible    ${unq_firstBannerActive}
    
Verify PUBG in Top Selling Section
    [Documentation]    Assertion to verify whether PUBG product is visible in Top Selling section or not.
    Scroll Element Into View    ${txt_PUBGcard}
    Mouse Over    ${btn_quickBuyPUBG}
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_quickBuyPUBG}
    Element Should Be Visible    ${unq_quickBuyPUBGPage}

Verify PB in Top Selling Section
    [Documentation]    Assertion to verify whether Point Blank product is visible in Top Selling section or not.
    Scroll Element Into View    ${txt_PBcard}
    Mouse Over    ${txt_PBcard}
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_quickBuyPB}
    Element Should Be Visible    ${unq_quickBuyPBPage}

Verify Mobile Legends in Top Selling Section
    [Documentation]    Assertion to verify whether Mobile Legends product is visible in Top Selling section or
    ...                not.
    Scroll Element Into View    ${txt_MLcard}
    Mouse Over    ${txt_MLcard}
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_quickBuyML}
    Element Should Be Visible    ${unq_quickBuyMLPage}

Verify Garena Shell in Top Selling Section
    [Documentation]    Assertion to verify whether Mobile Legends product is visible in Top Selling section or
    ...                not.
    Scroll Element Into View    ${txt_GScard}
    Mouse Over    ${txt_GScard}
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_quickBuyGS}
    Element Should Be Visible    ${unq_quickBuyGSPage}

Verify Steam ID Product
    [Documentation]    Assertion to verify whether Indonesia's Steam product is visible in Products/Categories 
    ...                section or not.
    Scroll Element Into View    ${btn_steamWalletCard}
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_steamWalletCard}
    Element Should Be Visible    ${unq_steamIDPage}

Verify Google Play Gift Card ID Product
    [Documentation]    Assertion to verify whether Indonesia's Google Play Gift product is visible in 
    ...                Products/Categories section or not in Staging website.
    Scroll Element Into View    ${btn_googlePlayGiftCard}
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_googlePlayGiftCard}
    Element Should Be Visible    ${unq_googleplayGiftpage2}

Verify Google Play Gift Card ID Product For Preprod and Prod
    [Documentation]    Assertion to verify whether Indonesia's Google Play Gift product is visible in 
    ...                Products/Categories section or not in Pre-Production and Production website.
    Scroll Element Into View    ${btn_googlePlayGiftCard}
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_googlePlayGiftCard}
    Element Should Be Visible    ${unq_googleplayGiftpage3}

Verify Google Play Gift Card TW Product
    [Documentation]    Assertion to verify whether Taiwan's Google Play Gift product is visible in 
    ...                Products/Categories section or not in Staging website.
    Scroll Element Into View    ${btn_googlePlayGiftCardTW}
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_googlePlayGiftCardTW}
    Element Should Be Visible    ${unq_googleplayGiftpageTW}

Verify Google Play Gift Card TW Product For Preprod and Prod
    [Documentation]    Assertion to verify whether Taiwan's Google Play Gift product is visible in 
    ...                Products/Categories section or not in Pre-Production and Production website.
    Scroll Element Into View    ${btn_googlePlayGiftCardTW}
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_googlePlayGiftCardTW}
    Element Should Be Visible    ${unq_googleplayGiftpageTW2}

Verify Life After ID Product
    [Documentation]    Assertion to verify whether Indonesia's Life After product is visible in 
    ...                Products/Categories section or not in Staging website.
    Scroll Element Into View    ${btn_lifeAfterCard}
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_lifeAfterCard}
    Element Should Be Visible    ${unq_lifeafterIDPage2}

Verify Life After ID Product For Preprod and Prod
    [Documentation]    Assertion to verify whether Indonesia's Life After product is visible in 
    ...                Products/Categories section or not in Pre-Production and Production website.
    Scroll Element Into View    ${btn_lifeAfterCard2}
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_lifeAfterCard2}
    Element Should Be Visible    ${unq_lifeafterIDPage3}

Verify Saint Seiya ID Product
    [Documentation]    Assertion to verify whether Indonesia's Saint Seiya product is visible in 
    ...                Products/Categories section or not in Staging website.
    Scroll Element Into View    ${btn_saintSeiyaCard}
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_saintSeiyaCard}
    Element Should Be Visible    ${unq_saintSeiyaIDpage2}

Verify Saint Seiya ID Product For Preprod and Prod
    [Documentation]    Assertion to verify whether Indonesia's Saint Seiya product is visible in 
    ...                Products/Categories section or not in Pre-Production and Production website.
    Scroll Element Into View    ${btn_saintSeiyaCard2}
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_saintSeiyaCard2}
    Element Should Be Visible    ${unq_saintSeiyaIDpage3}

Verify Garena Shells TW Product
    [Documentation]    Assertion to verify whether Taiwan's Garena Shell product is visible in 
    ...                Products/Categories section or not in Staging website.
    Scroll Element Into View    ${btn_garenaShells}
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_garenaShells}
    Element Should Be Visible    ${unq_garenaShellsTW}

Verify Garena Shells TW Product For Preprod and Prod
    [Documentation]    Assertion to verify whether Taiwan's Garena Shell product is visible in 
    ...                Products/Categories section or not in Pre-Production and Production website.
    Scroll Element Into View    ${btn_garenaShells2}
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_garenaShells2}
    Element Should Be Visible    ${unq_garenaShellsTW}

Verify Mobile Legends TW Product
    [Documentation]    Assertion to verify whether Taiwan's Mobile Legends product is visible in 
    ...                Products/Categories section or not in Staging website.
    Scroll Element Into View    ${btn_mobileLegends}
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_mobileLegends}
    Element Should Be Visible    ${unq_mobileLegendsTW}

Verify Mobile Legends TW Product For Preprod and Prod
    [Documentation]    Assertion to verify whether Taiwan's Mobile Legends product is visible in 
    ...                Products/Categories section or not in Pre-Production and Production website.
    Scroll Element Into View    ${btn_mobileLegends}
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_mobileLegends}
    Element Should Be Visible    ${unq_mobileLegendsTW2}

Verify Learn About P Points
    [Documentation]    Assertion to verify whether user is redirect to P Points support page through P Points
    ...                section in homepage.
    IF    $checkTaiwan not in $url_usedUrl
        Scroll Element Into View    ${btn_learnAboutPPoints}
        Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_learnAboutPPoints}
    ELSE IF    $checkTaiwan in $url_usedUrl
        IF    $checkStaging in $url_usedUrl or $checkPreprod in $url_usedUrl
            Scroll Element Into View    ${btn_learnAboutPoints}
            Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_learnAboutPoints}
        ELSE IF    $checkStaging not in $url_usedUrl and $checkPreprod not in $url_usedUrl
            Scroll Element Into View    ${btn_learnAboutPPoints}
            Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_learnAboutPPoints}
        END
    END
    Element Should Be Visible    ${unq_whatIsPPoints}

Verify Why Wallet Codes CTA
    [Documentation]    Assertion to verify whether user is redirected to Why Us support page through Wallet
    ...                Codes Experience section.
    Scroll Element Into View    ${btn_whyWalletCodes}
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_whyWalletCodes}
    Element Should Be Visible    ${unq_whyWalletCodes}

Verify What is P Point CTA
    [Documentation]    Assertion to verify whether user is redirected to P Point support page through Wallet
    ...                Codes Experience section.
    IF    $checkTaiwan not in $url_usedUrl
        Scroll Element Into View    ${btn_pPointsDefinition}
        Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_pPointsDefinition}        
    ELSE IF    $checkTaiwan in $url_usedUrl
        IF    $checkStaging in $url_usedUrl or $checkPreprod in $url_usedUrl
            Scroll Element Into View    ${btn_pointsDefinition}
            Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_pointsDefinition}        
        ELSE IF    $checkStaging not in $url_usedUrl and $checkPreprod not in $url_usedUrl
            Scroll Element Into View    ${btn_pPointsDefinition}   
            Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_pPointsDefinition}        
        END
    END
    Element Should Be Visible    ${unq_whatIsPPoints}

Log In Before Proceed
    [Documentation]    Allow user to log in but user must be in already in login page.
    Input Text    ${inp_emailLogin}    ${valid_email2}
    Input Password    ${inp_passwordLogin}    ${valid_password}
    #Executor need to verify the recaptcha V3
    Execute Manual Step    Bypass recaptcha
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_submitLogin}
    Wait Until Element Is Visible    ${unq_loggedIn}    timeout=30s
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${unq_loggedIn}

Verify Daily Rewards Definition CTA
    [Documentation]    Assertion to verify whether user is redirected to Daily Rewards support page through Wallet
    ...                Codes Experience section.
    Scroll Element Into View    ${btn_dailyRewardsDefinition}
    Wait Until Element Is Visible    ${btn_dailyRewardsDefinition}
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_dailyRewardsDefinition}
    Log In Before Proceed
    Element Should Be Visible    ${unq_whatIsDailyRewards}

Create Top Menu Elements List Staging and Preprod
    [Documentation]    Return list of Top Menu's elements in Staging and Preprod website.
    @{topmenu}    Create List    ${img_logoTop}    ${drd_contactUsTop}    ${drd_productsTop}
        ...    ${btn_blogTop}    ${btn_registerTop}    ${btn_loginTop}    ${drd_language}
    RETURN    ${topmenu}

Create Top Menu Elements List Production ID
    [Documentation]    Return list of Top Menu's elements in Indonesia's Production website.
    @{topmenu}    Create List    ${img_logoTop}    ${drd_contactUsTop}    ${drd_productsTop}
            ...    ${btn_blogTop}    ${btn_registerTop2}    ${btn_loginTop2}    ${drd_language}
    RETURN    ${topmenu}

Create Top Menu Elements List Production TW
    [Documentation]    Return list of Top Menu's elements in Taiwan's Production website.
    @{topmenu}    Create List    ${img_logoTop}    ${drd_contactUsTop}    ${drd_productsTop}
            ...    ${btn_blogTopTW}    ${btn_registerTop}    ${btn_loginTop}    ${drd_language}
    RETURN    ${topmenu}

Verify Top Menu Elements
    [Documentation]    Assertion for Top Menu elements whether it's visible in the current page or not.
    IF    $checkStaging in $url_usedUrl or $checkPreprod in $url_usedUrl
        @{topmenu}    Create Top Menu Elements List Staging and Preprod
    ELSE IF    $checkStaging not in $url_usedUrl and $checkPreprod not in $url_usedUrl
        IF    $checkTaiwan not in $url_usedUrl
            @{topmenu}    Create Top Menu Elements List Production ID
        ELSE IF    $checkTaiwan in $url_usedUrl
            @{topmenu}    Create Top Menu Elements List Production TW
        END
    END
    Verify if Elements are Visible    @{topmenu}

Verify Contact Us Menu and Submenu
    [Documentation]    Assertion for Contact Us menu and its submenu whether it's visible or not.
    Mouse Over    ${drd_contactUsTop}
    Element Should Be Visible    ${opt_contactUs}
    Element Should Be Visible    ${opt_wcB2B}

Verify Products Menu and Submenu
    [Documentation]    Assertion for Product menu and its submenu whether it's visible or not.
    Mouse Over    ${drd_productsTop}
    IF    $checkTaiwan not in $url_usedUrl and $checkStaging in $url_usedUrl
        Element Should Be Visible    ${opt_steamProduct}
    END
    IF    $checkTaiwan not in $url_usedUrl and $checkStaging in $url_usedUrl
        Scroll Element Into View    ${opt_saintseiyaIDProduct}
    ELSE IF    $checkTaiwan not in $url_usedUrl
        Scroll Element Into View    ${opt_saintseiyaIDProduct2}
    ELSE IF    $checkTaiwan in $url_usedUrl
        Scroll Element Into View    ${opt_mobileLegendsTW}
        Scroll Element Into View    ${opt_robloxTWProduct}
        Scroll Element Into View    ${opt_garenaTWProduct}
    END
    
Verify Language Menu and Submenu
    [Documentation]    Assertion for Language menu and its submenu whether it's visible or not.
    Mouse Over    ${drd_language}
    IF    $checkTaiwan not in $url_usedUrl
        Element Should Be Visible    ${opt_enLanguage}
        Element Should Be Visible    ${opt_idLanguage}
    ELSE IF    $checkTaiwan in $url_usedUrl
        Element Should Be Visible    ${opt_chinese}
        Element Should Be Visible    ${opt_englishTW}
    END

Verify My P Points and My Accounts Menu
    [Documentation]    Assertion for My P Points and My Accounts menus whether it's visible or not.
    IF    $checkTaiwan not in $url_usedUrl
        Element Should Be Visible    ${drd_mypPointsTop}
        Element Should Be Visible    ${drd_myAccountsTop}
    ELSE IF    $checkTaiwan in $url_usedUrl
        IF    $checkStaging in $url_usedUrl or $checkPreprod in $url_usedUrl
            Element Should Be Visible    ${drd_myPointsTop}
        ELSE
            Close Modal Pop-up
            Element Should Be Visible    ${drd_mypPointsTop}
        END
        Element Should Be Visible    ${drd_myAccountsTop}
    END

Verify My P Points and My Accounts Submenu
    [Documentation]    Assertion for My P Points and My Accounts submenus whether it's visible or not.
    IF    $checkTaiwan not in $url_usedUrl
        Mouse Over    ${drd_mypPointsTop}
    ELSE IF    $checkTaiwan in $url_usedUrl
        IF    $checkStaging in $url_usedUrl or $checkPreprod in $url_usedUrl
            Mouse Over    ${drd_myPointsTop}
        ELSE
            Mouse Over    ${drd_mypPointsTop}
        END
    END
    Element Should Be Visible    ${opt_redeemHistory}
    Element Should Be Visible    ${opt_dailyRewards}
    Sleep    1
    Mouse Over    ${drd_myAccountsTop}
    Element Should Be Visible    ${opt_myAccounts}
    Element Should Be Visible    ${opt_transactionHistory}
    Element Should Be Visible    ${opt_logout}

Verify Top Selling Section
    [Documentation]    Assertion for Top Selling section whether it's visible or not.
    Scroll Element Into View    ${unq_topSelling}
    IF    $checkStaging in $url_usedUrl and $checkTaiwan not in $url_usedUrl
        Element Should Be Visible    ${txt_PUBGcard}
    ELSE IF    $checkTaiwan in $url_usedUrl
        Element Should Be Visible    ${btn_mobileLegends}
    ELSE
        Element Should Not Be Visible    ${txt_PUBGcard}
    END

Verify Product/Categories Section
    [Documentation]    Assertion for Products/Categories section whether it's visible or not.
    Scroll Element Into View    ${unq_productsOrCategories}
    IF    $checkTaiwan not in $url_usedUrl
        Element Should Be Visible    ${btn_steamWalletCard}
        Element Should Be Visible    ${btn_googlePlayGiftCard}
        IF    $checkStaging in $url_usedUrl
            Element Should Be Visible    ${btn_lifeAfterCard}
            Element Should Be Visible    ${btn_saintSeiyaCard}
        ELSE
            Element Should Be Visible    ${btn_lifeAfterCard2}
            Element Should Be Visible    ${btn_saintSeiyaCard2}
        END
    ELSE IF    $checkTaiwan in $url_usedUrl
        Element Should Be Visible    ${btn_googlePlayGiftCardTW}
        Element Should Be Visible    ${btn_mobileLegends}
        Element Should Be Visible    ${btn_garenaShells}
    END

Verify Available Payment Methods
    [Documentation]    Assertion for Payment Methods section whether it's visible or not.
    Scroll Element Into View    ${unq_paymentMethods}
    IF    $checkStaging in $url_usedUrl or $checkPreprod in $url_usedUrl
        IF    $checkTaiwan not in $url_usedUrl
            @{paymentMethods}    Create List    ${img_paymentIDOVO}    ${img_paymentIDGopay}    ${img_paymentMasterVisa}
            ...    ${img_paymentIDShopeepay}    ${img_paymentIDPPoints}
        ELSE IF    $checkTaiwan in $url_usedUrl
        @{paymentMethods}    Create List    ${img_paymentTWTaiwanMobile}    ${img_paymentMasterVisa}
        ...    ${img_paymentTWTStar}    ${img_paymentTWChungHwa}    ${img_paymentTW7elevenIbon}
        ...    ${img_paymentTWAsiaPasificTelecom}    ${img_paymentTWFET}    ${img_paymentTWFamiPort}
        ...    ${img_paymentTWVirtualATM}    ${img_paymentIDPPoints} 
        END
    ELSE IF    $checkStaging not in $url_usedUrl and $checkPreprod not in $url_usedUrl
        IF    $checkTaiwan in $url_usedUrl
            @{paymentMethods}    Create List    ${img_paymentTWTaiwanMobile}    ${img_paymentMasterVisa}
            ...    ${img_paymentTWTStar}    ${img_paymentTWChungHwa}    ${img_paymentTW7elevenIbon}
            ...    ${img_paymentTWAsiaPasificTelecom}    ${img_paymentTWFET}    ${img_paymentTWFamiPort}
            ...    ${img_paymentTWVirtualATM}    ${img_paymentIDPPoints2}
        ELSE
            @{paymentMethods}    Create List    ${img_paymentIDOVO}    ${img_paymentIDGopay}    ${img_paymentMasterVisa}
            ...    ${img_paymentIDShopeepay}    ${img_paymentIDPPoints2}    ${img_paymentIDDana}    ${img_paymentIDBCA}
            ...    ${img_paymentIDMandiri}    ${img_paymentIDBNI}    ${img_paymentIDBRI}    ${img_paymentIDCIMB}
            ...    ${img_paymentIDPermata2}    ${img_paymentIDLinkAja}    ${img_paymentIDAlfamart}
        END   
    END
    Verify if Elements are Visible    @{paymentMethods}

Verify About P Points
    [Documentation]    Assertion for About P Points section whether it's visible or not.
    IF    $checkTaiwan not in $url_usedUrl
        Scroll Element Into View    ${btn_learnAboutPPoints}
    ELSE IF    $checkTaiwan not in $url_usedUrl
        Scroll Element Into View    ${btn_learnAboutPoints}
    END

Verify Wallet Codes Experience Section
    [Documentation]    Assertion for Wallet Codes Experience section whether it's visible or not.
    IF    $checkTaiwan not in $url_usedUrl
        @{wcExperience}    Create List    ${btn_whyWalletCodes}    ${txt_whyWalletCodesDesc}    
        ...    ${btn_pPointsDefinition}    ${txt_pPointsDefinitionDesc}    ${btn_dailyRewardsDefinition}    
        ...    ${txt_dailyRewardsDefinitonDesc}
    ELSE IF    $checkTaiwan in $url_usedUrl
        IF    $checkStaging in $url_usedUrl or $checkPreprod in $url_usedUrl
            @{wcExperience}    Create List    ${btn_whyWalletCodes}    ${txt_whyWalletCodesDesc}    
            ...    ${btn_pointsDefinition}    ${txt_pPointsDefinitionDesc}    ${btn_dailyRewardsDefinition}    
            ...    ${txt_dailyRewardsDefinitonDesc}
        ELSE
            @{wcExperience}    Create List    ${btn_whyWalletCodes}    ${txt_whyWalletCodesDesc}    
            ...    ${btn_pPointsDefinition}    ${txt_pPointsDefinitionDesc}    ${btn_dailyRewardsDefinition}    
            ...    ${txt_dailyRewardsDefinitonDesc}
        END
        
    END
    Verify if Elements are Visible    @{wcExperience}

Verify Footer Social Media
    [Documentation]    Assertion for Social Media section in Footer whether it's visible or not.
    Scroll Element Into View    ${unq_copyright}
    @{socmed}    Create List    ${btn_facebook}    ${btn_instagram}    ${btn_linkedin}    ${btn_youtube}
    Verify if Elements are Visible    @{socmed}

Verify Footer Countries
    [Documentation]    Assertion for Countries section in Footer whether it's visible or not.
    Scroll Element Into View    ${drd_countriesList}
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${drd_countriesList}
    @{country}    Create List    ${opt_countryID}    ${opt_countryPH}    ${opt_countryTW}    ${opt_countryMY}
    Verify if Elements are Visible    @{country}
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${drd_countriesList}

Verify Footer Quick Links
    [Documentation]    Assertion for Quick Links section in Footer whether it's visible or not.
    @{quickLinks}    Create List    ${unq_quickLinks}    ${btn_quickHome}    ${btn_quickWhyWalletCodes}
    ...    ${btn_quickHome}    
    IF    $checkTaiwan not in $url_usedUrl
        Append To List    ${quickLinks}    ${btn_quickWCB2B}
    ELSE IF    $checkTaiwan in $url_usedUrl
        IF    $checkStaging in $url_usedUrl
            Append To List    ${quickLinks}    ${btn_quickWCB2B}
        ELSE IF    $checkPreprod in $url_usedUrl
            Append To List    ${quickLinks}    ${btn_quickBulkPurchase}
        ELSE
            Append To List    ${quickLinks}    ${btn_quickBulkPurchase2}
        END
    END
    Verify if Elements are Visible    @{quickLinks}

Verify Footer Support
    [Documentation]    Assertion for Support section in Footer whether it's visible or not.
    @{support}    Create List    ${unq_support}    ${btn_supportSupport}    ${btn_terms&conditionSupport}
    ...    ${btn_privacy&policySupport}    ${btn_supportContactUs}
    Verify if Elements are Visible    @{support}

Verify Footer Awards
    [Documentation]    Assertion for Awards section in Footer whether it's visible or not.
    Element Should Be Visible    ${unq_awards}
    Element Should Be Visible    ${btn_awardsAPSA}
    Element Should Be Visible    ${btn_awardsACA}

Verify Footer Google Play CTA
    [Documentation]    Assertion for Google Play CTA in Footer whether it's visible or not.
    Element Should Be Visible    ${unq_nowAvailable}
    Element Should Be Visible    ${btn_playStore}

Check If User Has Been Logged In
    [Documentation]    Check whether current user has been logged in or not. If not, it will try to log in.
    ${before}    Get Selenium Implicit Wait
    Set Selenium Implicit Wait    1s
    ${logged_in}    Run Keyword And Return Status    Element Should Be Visible    ${drd_myAccountsTop}
    Set Selenium Implicit Wait    ${before}
    IF    not $logged_in
        Log in to Wallet Codes website    english=${False}
    END

Check Log Out
    [Documentation]    Check whether current user has been logged out or not. If not, it will try to log out.
    ${before}    Get Selenium Implicit Wait
    Set Selenium Implicit Wait    1s
    ${logged_in}    Run Keyword And Return Status    Element Should Be Visible    ${drd_myAccountsTop}
    Set Selenium Implicit Wait    ${before}
    IF    $logged_in
        Mouse Over    ${drd_myAccountsTop}
        Wait Until Keyword Succeeds    10s    1s    Click Element    ${opt_logout}
        Wait Until Element Is Not Visible    ${drd_myAccountsTop}
    END

Back to Indonesia's Website If Not In Taiwan
    [Documentation]    Change country website into Indonesia if current country is not in Taiwan.
    IF    $checkStaging not in $url_usedUrl and $checkPreprod not in $url_usedUrl and $checkTaiwan not in $url_usedUrl  
            Change Country Base    Indonesia 
    END
# ====================================================================================================