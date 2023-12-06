# ====================================================================================================
*** Settings ***
Documentation    Transaction History page data validation and functionalities.
...              
...              Test Environment: *${global_env}*
Resource    ../../Resources/imports.resource
Test Tags    Regression
Suite Setup    Go to Wallet Codes Website    ${global_env}    chrome    10
Suite Teardown    End Testing
# ====================================================================================================



# ====================================================================================================
** Variables ***
${checkTransactionHistory}    /user-profile/transaction-history
${emptyTransaction}    C10011
${transactionCTA}    C10623
${noTransactionAccount}    No Transaction
# ====================================================================================================



# ====================================================================================================
*** Test Cases ***
C10011 Handle empty transaction
    [Documentation]    Checking UI for empty transaction also its CTA.
    [Tags]    Staging    Preprod    Production    Global    Taiwan    Retest
    Transaction History Setup
    Verify Empty Transaction History
    Click On Shop Now Button
    Check If Redirected to Homepage

C10623 Transaction history page CTA
    [Documentation]    Checking functionality of transaction history's CTA.
    [Tags]    Staging    Preprod    Production    Taiwan    Retest
    Skip If This is not Taiwan Website
    @{header}    Create Transaction History Table's Header List
    Transaction History Setup
    Verify Transaction History Column Header    @{header}
    Verify Contact Support Button
    Go to Transaction History page
    Verify Reorder Button
# ====================================================================================================
    



# ====================================================================================================
***Keyword***
Transaction History Setup
    [Documentation]    Configuration before executing test steps in Transaction History suite.
    ${currentUrl}    Get Location
    ${before}    Get Selenium Implicit Wait
    Set Selenium Implicit Wait    1s
    ${logged_in}    Run Keyword And Return Status    Element Should Be Visible    ${drd_myAccountsTop}
    Set Selenium Implicit Wait    ${before}
    IF    $checkTransactionHistory in $currentUrl and $logged_in
        Reload Page
        Wait Until Element Is Visible    ${unq_transactionHistoryPage}
    ELSE IF    $checkTransactionHistory not in $currentUrl and $logged_in
        Wait Until Keyword Succeeds    10s    1s    Mouse Over    ${drd_myAccountsTop}
        Wait Until Keyword Succeeds    10s    1s    Click Element    ${opt_myAccounts}
        Wait Until Element Is Visible    ${txt_nameMyProfile}    5s
        ${accountName}    Check Current Account's Name
        IF    $noTransactionAccount in $accountName
            Wait Until Keyword Succeeds    10s    1s    Mouse Over    ${drd_myAccountsTop}
            Sleep    1s
            Wait Until Keyword Succeeds    10s    1s    Click Element    ${opt_logout}
            Close Modal Pop-up
            Wait Until Element Is Not Visible    ${drd_myAccountsTop}
            Log in to Wallet Codes website    ${valid_email3}    ${valid_password3}    english=${False}
            Go to Transaction History page
        ELSE
            Go to Transaction History page
        END
    ELSE IF    $checkTransactionHistory not in $currentUrl and not $logged_in
        Check If This is Taiwan Website
        IF    $emptyTransaction in $TEST_NAME
            Log in to Wallet Codes website    email=${valid_email4}    english=${False}
        ELSE IF    $transactionCTA in $TEST_NAME
            Log in to Wallet Codes website    ${valid_email3}    ${valid_password3}    english=${False}
        END
        Go to Transaction History page
    END

Go to Transaction History page
    [Documentation]    Redirect user to Transaction History page.
    Wait Until Keyword Succeeds    10s    1s    Mouse Over    ${drd_myAccountsTop}
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${opt_transactionHistory}
    Wait Until Element Is Visible    ${unq_transactionHistoryPage}

Go to Profile Page
    [Documentation]    Redirect user to User's Profile page.
    Wait Until Keyword Succeeds    10s    1s    Mouse Over    ${drd_myAccountsTop}
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${opt_myAccounts}
    Wait Until Element Is Visible    ${unq_myProfilePage}

Check Current Account's Name
    [Documentation]    Return current user profile name.
    ${account_name}    Get Text    ${txt_nameMyProfile}
    RETURN    ${account_name}

Check If Redirected to Homepage
    [Documentation]    Assertion to check whether user is redirected to Homepage or not.
    IF    $checkTaiwan not in $url_usedUrl
        Wait Until Element Is Visible    ${unq_homepage}
    ELSE IF    $checkTaiwan in $url_usedUrl
        IF    $checkStaging not in $url_usedUrl and $checkPreprod not in $url_usedUrl
            Close Modal Pop-up
        END
        Wait Until Element Is Visible    ${unq_homepageTWEnglish}
    END

Verify Transaction History Column Header
    [Documentation]    Assertion to verify whether column headers in the transaction history table.
    [Arguments]    @{headers}
    FOR    ${header}    IN    @{headers}
        Run Keyword And Continue On Failure    Element Should Be Visible    ${header}
    END

Verify Empty Transaction History
    [Documentation]    Assertion to verify whether transaction history is empty or not.
    ${before}    Get Selenium Implicit Wait
    Set Selenium Implicit Wait    5s
    Run Keyword And Continue On Failure    Element Should Be Visible    ${unq_emptyTransactionHistory}
    Set Selenium Implicit Wait    ${before}
    Execute Javascript    window.scrollTo(0,250)

Click On Shop Now Button
    [Documentation]    Click on Shop Now CTA.
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_shopNowTransactionHistory}

Create Transaction History Table's Header List
    [Documentation]    Return list of column header's name in transaction history table.
    @{header}    Create List    ${txt_dateColumnHeaderTrxHistory}    ${txt_invoiceColumnHeaderTrxHistory}
    ...    ${txt_productColumnHeaderTrxHistory}    ${txt_paymentOptionColumnHeaderTrxHistory}    
    ...    ${txt_amountColumnHeaderTrxHistory}    ${txt_paymentStatusColumnHeaderTrxHistory}
    ...    ${txt_actionColumnHeaderTrxHistory}
    RETURN    @{header}

Verify Contact Support Button
    [Documentation]    Assertion to verify contact support CTA in transaction history that's not empty.
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_contactSupportTrxHistory}
    Wait Until Element Is Visible    ${unq_contactUs}

Verify Reorder Button
    [Documentation]    Assertion to verify reorder CTA in transaction history that has succesful transaction.
    ${orderedDenom}    Get Text    ${txt_row1ProductTrxHistory}
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${btn_reorderTrxHistory}
    Wait Until Element Is Visible    ${unq_reorderDenomPage}    10s
    ${currentDenom}    Get Text    ${txt_reorderDenomTitle}
    Run Keyword And Continue On Failure    Should Match    ${orderedDenom}    ${currentDenom}    ignore_case=True
# ====================================================================================================