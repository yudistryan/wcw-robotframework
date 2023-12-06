# ====================================================================================================
*** Settings ***
Documentation    P Points History functionalities and UI conformation.
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
# C10630 P Point balance validation
#     [Tags]    Staging    Global    Taiwan    New
#     My P Points Setup
#     ${points}    Get Total P Points
#     Log    ${points}


# C10634 Spend P Points in any transaction

C10639 Handle empty p points history
    [Documentation]    Conform UI for empty P Points History.
    [Tags]    Staging    Preprod    Production    Global    Taiwan
    IF    $checkStaging in $url_usedUrl
        My P Points Setup    ${valid_email4}    ${valid_password}
    ELSE
        My P Points Setup
    END
    Verify Empty P Point History
# ====================================================================================================
    


# ====================================================================================================
*** Keywords ***
Verify Empty P Point History
    [Documentation]    Assertion to verify whether p point histoyr is empty or not.
    Run Keyword And Continue On Failure    Wait Until Element Is Visible    ${unq_emptyPPointHistory}    3s

# Get Total P Points
    # @{total}    Execute Async Javascript    
    # ...    text = [];
    # ...    for(let i=1;i<11;i++){
    # ...        text.push(document.evaluate('/html[1]/body[1]/div[1]/main[1]/div[1]/section[1]/div[1]/div[1]/div[2]/div[2]/table[1]/tbody[1]/tr['+i+']/td[3]/span[1]',
    # ...        document, null, XPathResult.STRING_TYPE, null).stringValue);
    # ...    }
    # ...    ops = [];
    # ...    points = [];
    # ...    for (let i=0;i<text.length;i++){
    # ...        ops.push(text[i][0]);
    # ...        points.push(parseInt(text[i][1]));
    # ...    }
    # ...    ops.shift();
    # ...    total = 0;
    # ...    for (let i=0;i<ops.length;i++){
    # ...        if(i==0){
    # ...            if(ops[i]=='+'){
    # ...                total = points[0]+points[1];
    # ...            } else {
    # ...                total = points[0]-points[1];
    # ...            }
    # ...        } else if (i>0){
    # ...            if(ops[i]=='+'){
    # ...                total = total+points[i+1];
    # ...            } else {
    # ...                total = total-points[i+1];
    # ...            }
    # ...        } else {
    # ...            console.log('Erroorrrrrrrr');
    # ...        }
    # ...    }
    # ...    return text;
    # RETURN    @{total}
# ====================================================================================================