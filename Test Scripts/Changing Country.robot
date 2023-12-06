# ====================================================================================================
*** Settings ***
Documentation    Change country base and test each website unique elements.
...              
...              Test Environment: *${global_env}*
Resource    ../Resources/imports.resource
Test Tags    Regression
Test Setup    Go to Wallet Codes Website    ${global_env}    chrome
Test Teardown    End Testing
# ====================================================================================================



# ====================================================================================================
*** Variables ***
# ====================================================================================================



# ====================================================================================================
*** Test Cases ***
C10014 Malaysia's website
    [Documentation]    Check for changing country website into Malaysia.
    [Tags]    Staging    Preprod    Production    Global    Taiwan
    Change Country Base    Malaysia
    Verify Available Language in Malaysia
    Scroll Into Malaysia Payment Methods
    Verify Available Payment Methods in Malaysia
    Verify WC Facebook for MY, MM, TH

C10015 Indonesia's website
    [Documentation]    Check for changing country website into Indonesia.
    [Tags]    Staging    Preprod    Production    Global    Taiwan
    Check If Current Country is Taiwan
    Verify Available Language in Indonesia
    Scroll Into Indonesia Payment Methods
    Verify Available Payment Methods in Indonesia
    Verify WC Facebook for ID and PH

C10016 Thailand's website
    [Documentation]    Check for changing country website into Thailand.
    [Tags]    Staging    Preprod    Production    Global    Taiwan
    Skip Blacklisted Test Cases
    Change Country Base    Thailand
    Verify Available Language in Thailand
    Scroll Into Thailand Payment Methods
    Verify Available Payment Methods in Thailand
    Verify WC Facebook for MY, MM, TH
    Verify WC Instagram Thailand
    Verify WC Line Thailand
    
C10017 Myanmar's website
    [Documentation]    Check for changing country website into Myanmar.
    [Tags]    Staging    Preprod    Production    Global    Taiwan
    Skip Blacklisted Test Cases
    Change Country Base    Myanmar
    Verify Available Language in Myanmar
    Scroll Into Myanmar Payment Methods
    Verify Available Payment Methods in Myanmar
    Verify WC Facebook for MY, MM, TH

C10018 Philippines' website
    [Documentation]    Check for changing country website into Philippines.
    [Tags]    Staging    Preprod    Production    Global    Taiwan
    Change Country Base    Phillippines
    Verify Available Language in Phillippines
    Scroll Into Phillippines Payment Methods
    Verify Available Payment Methods in Phillippines
    Verify WC Facebook for ID and PH
# ====================================================================================================



# ====================================================================================================
*** Keywords ***
Verify Available Language in ${country}
    [Documentation]    Verify languages for each country base. Available countries: Malaysia, Indonesia, 
    ...                Myanmar, Phillippines, Thailand and Taiwan.
    ${languages}    Language Repository    ${country}
    Wait Until Keyword Succeeds    10s    1s    Mouse Over    ${drd_language}
    FOR    ${language}    IN    @{languages}
        Element Should Be Visible    ${language}
    END

Language Repository
    [Documentation]    Return list of a country's language.
    [Arguments]    ${country}
    @{MY}    Create List    ${opt_englishMY}
    @{ID}    Create List    ${opt_enLanguage}    ${opt_idLanguage}
    @{TH}    Create List    ${opt_englishTH}    ${opt_thai}
    @{MM}    Create List    ${opt_burmese}    ${opt_englishMM}
    @{PH}    Create List    ${opt_englishPH}
    @{TW}    Create List    ${opt_chinese}    ${opt_englishTW}
    IF    $country=='Malaysia'
        RETURN    ${MY}
    ELSE IF    $country=='Indonesia'
        RETURN    ${ID}
    ELSE IF    $country=='Thailand'
        RETURN    ${TH}
    ELSE IF    $country=='Myanmar'
        RETURN    ${MM}
    ELSE IF    $country=='Phillippines'
        RETURN    ${PH}
    ELSE IF    $country=='Taiwan'
        RETURN    ${TW}
    END

Scroll Into ${country} Payment Methods
    [Documentation]    Scrolling to Payment Methods section in each country Homepage. 
    ...                Available countries: Malaysia, Indonesia, Myanmar, Phillippines, Thailand and Taiwan.
    IF    $country=='Malaysia'
        IF    $checkStaging in $url_usedUrl or $checkPreprod in $url_usedUrl
            Scroll Element Into View    ${unq_paymentMethodsMY}
        ELSE
            Scroll Element Into View    ${unq_paymentMethodsMY2}
        END
    ELSE IF    $country=='Indonesia'
        Scroll Element Into View    ${unq_paymentMethodsID}
    ELSE IF    $country=='Thailand'
        Scroll Element Into View    ${unq_paymentMethodsTH}
    ELSE IF    $country=='Myanmar'
        Scroll Element Into View    ${unq_paymentMethodsMM}
    ELSE IF    $country=='Phillippines'
        Scroll Element Into View    ${unq_paymentMethodsPH}
    ELSE IF    $country=='Taiwan'
        Scroll Element Into View    ${unq_paymentMethodsTW}
    END

Verify Available Payment Methods in ${country}
    [Documentation]    Assertion to verify available payment methods in each country Homepage.
    ...                Available countries: Malaysia, Indonesia, Myanmar, Phillippines, Thailand and Taiwan.
    ${paymentMethods}    Payment Methods Repository    ${country}
    FOR    ${payment}    IN    @{payment methods}
        Run Keyword And Continue On Failure    Element Should Be Visible    ${payment}
    END

Payment Methods Repository
    [Documentation]    Return list of available payment method in a country.
    [Arguments]    ${country}
    IF    $country=='Indonesia'
        IF    $checkStaging in $url_usedUrl or $checkPreprod in $url_usedUrl
            @{paymentMethods}    Create List    ${img_paymentIDOVO}    ${img_paymentIDGopay}    ${img_paymentMasterVisa}
        ...    ${img_paymentIDShopeepay}    ${img_paymentIDPPoints}
        ELSE IF    $checkStaging not in $url_usedUrl and $checkPreprod not in $url_usedUrl
            @{paymentMethods}    Create List    ${img_paymentIDOVO}    ${img_paymentIDGopay}    ${img_paymentMasterVisa}
        ...    ${img_paymentIDShopeepay}    ${img_paymentIDPPoints2}    ${img_paymentIDDana}    ${img_paymentIDBCA}
        ...    ${img_paymentIDMandiri}    ${img_paymentIDBNI}    ${img_paymentIDBRI}    ${img_paymentIDCIMB}
        ...    ${img_paymentIDPermata}    ${img_paymentIDLinkAja}    ${img_paymentIDAlfamart}
        END
    ELSE IF    $country=='Thailand'
        IF    $checkStaging in $url_usedUrl or $checkPreprod in $url_usedUrl
            @{paymentMethods}    Create List    ${img_mixTH}    ${img_paypalTH}    ${img_linepayTH}
            ...    ${img_shopeepayTH}    ${img_inetBankingTH}
        ELSE
            @{paymentMethods}    Create List    ${img_linepayTH}    ${img_paymentMasterVisa}
            ...    ${img_2c2pTH}    ${img_paymentIDPPoints2}
        END
    ELSE IF    $country=='Myanmar'
        @{paymentMethods}    Create List    ${img_telenorMM}    ${img_mpuMM}
        ...    ${img_ayapayMM}    ${img_wavepayMM}    ${img_kbzpayMM}
        IF    $checkStaging in $url_usedUrl or $checkPreprod in $url_usedUrl
            Append To List    ${paymentMethods}    ${img_ppointsPayment}
        ELSE IF    $checkStaging not in $url_usedUrl or $checkPreprod not in $url_usedUrl
            Append To List    ${paymentMethods}    ${img_paymentIDPPoints2}
        END
    ELSE IF    $country=='Phillippines'
        IF    $checkStaging in $url_usedUrl or $checkPreprod in $url_usedUrl
            @{paymentMethods}    Create List    ${img_globePH}    ${img_7elevenPH}    ${img_gcashPH}
        ...    ${img_coinsPH}    ${img_smartPH}    ${img_grabpayPH}    ${img_bdoPH}    ${img_bpiPH}
        ...    ${img_metrobankPH}    ${img_pcaBayadPH}    ${img_pcaBDOPH}    ${img_ppointsPayment}
        ...    ${img_pcaECpayPH}
        ELSE IF    $checkStaging not in $url_usedUrl or $checkPreprod not in $url_usedUrl
            @{paymentMethods}    Create List    ${img_7elevenPH}    ${img_gcashPH}
        ...    ${img_coinsPH}    ${img_grabpayPH}    ${img_bdoPH}    ${img_bpiPH}
        ...    ${img_metrobankPH}    ${img_paymentIDPPoints2}
        END
    ELSE IF    $country=='Malaysia'
        @{paymentMethods}    Create List    ${img_paymentMasterVisa}
    END
    RETURN    @{paymentMethods}

Verify WC Facebook for MY, MM, TH
    [Documentation]    Verify footer facebook icon whether it's redirecting user to correct
    ...                url or not. This keyword is for Malaysia, Myanmar and Thailand.
    Wait Until Keyword Succeeds    10s    1s    Scroll Element Into View    ${unq_copyright}
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_facebookMY,MM,TH}
    ${currentUrls}    Get Locations
    IF    '/th' in $currentUrls[-1]
        Should Contain    ${currentUrls}[-1]    ${url_wcFacebookTH}
    ELSE IF    '/my' in $currentUrls[-1]
        Should Contain    ${currentUrls}[-1]    ${url_wcFacebookMY}
    ELSE IF    '/mm' in $currentUrls[-1]
        Should Contain    ${currentUrls}[-1]    ${url_wcFacebookMM}
    END
    Switch Window    url:${currentUrls}[0]

Verify WC Facebook for ID and PH
    [Documentation]    Verify footer facebook icon whether it's redirecting user to correct
    ...                url or not. This keyword is for Indonesia and Philippines.
    Scroll Element Into View    ${unq_copyright}
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_facebook}
    ${currentUrls}    Get Locations
    IF    '/id' in $currentUrls[-1]
        Should Contain    ${currentUrls}[-1]    ${url_wcFacebook}
    ELSE IF    '/ph' in $currentUrls[-1]
        Should Contain    ${currentUrls}[-1]    ${url_wcFacebookPH}
    END
    Switch Window    url:${currentUrls}[0]

Verify WC Instagram Thailand
    [Documentation]    Verify footer instagram icon whether it's redirecting user to correct
    ...                url or not. This keyword applied for all countries.
    Scroll Element Into View    ${unq_copyright}
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_instagram}
    ${currentUrls}    Get Locations
    Should Contain    ${currentUrls}[-1]    ${url_wcInstagramTH}
    Switch Window    url:${currentUrls}[0]

Verify WC Line Thailand
    [Documentation]    Verify footer line icon whether it's redirecting user to correct
    ...                url or not. This keyword only for Thailand.
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_lineFooter}
    ${currentUrls}    Get Locations
    Switch Window    url:${currentUrls}[-1]
    Run Keyword And Ignore Error    Wait Until Page Contains Element    ${btn_closeModalLineTH}    3s
    Run Keyword And Ignore Error    Click Element    ${btn_closeModalLineTH}
    Element Should Be Visible    ${unq_lineTHpage}

Check If Current Country is Taiwan
    [Documentation]    If current country is Taiwan it will change the country into Indonesia.
    IF    $checkTaiwan in $url_usedUrl
        Change Country Base    Indonesia
    END
# ====================================================================================================