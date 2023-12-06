# ====================================================================================================
*** Settings ***
Documentation    File for storing all resources including library and resources. 
Library    SeleniumLibrary    screenshot_root_directory=EMBED
Library    ScreenCapLibrary
Library    Dialogs
Library    XML
Library    OperatingSystem
Library    Collections
Library    String
Library    ../Library/checkoutFunctions.py
Resource    ../Resources/test_data.resource
Resource    ../Resources/test_resources.resource
Resource    ../Resources/rsc_homepage.resource
Resource    ../Resources/rsc_footer.resource
Resource    ../Resources/rsc_topMenu.resource
Resource    ../Resources/rsc_contactUsPage.resource
Resource    ../Resources/rsc_changingCountry.resource
Resource    ../Resources/rsc_myAccount.resource
Resource    ../Resources/rsc_registration.resource
Resource    ../Resources/rsc_login.resource
Resource    ../Resources/rsc_pPointsPage.resource
Resource    ../Resources/rsc_checkout.resource
# ====================================================================================================