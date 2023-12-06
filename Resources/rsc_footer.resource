# ====================================================================================================
*** Settings ***
Documentation    Resources management for *FOOTER* test suite.
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
# ====================================================================================================



# ====================================================================================================
*** Keywords ***
Go to Steam ID Page
    [Documentation]    Go to Steam Wallet product page in Indonesia website.
    Mouse Over    ${drd_productsTop}
    Click Element    ${opt_steamProduct}
    Wait Until Element Is Visible    ${unq_steamIDPage}

Go to Garena TW Page
    [Documentation]    Go to Garena product page in Taiwan website.
    Mouse Over    ${drd_productsTop}
    Click Element    ${opt_garenaTWProduct}
    Wait Until Element Is Visible    ${unq_garenaShellsTW2}

Scroll to Bottom of Page
    [Documentation]    Scroll page view into bottom of the page.
    Scroll Element Into View    ${unq_copyright}
# ====================================================================================================