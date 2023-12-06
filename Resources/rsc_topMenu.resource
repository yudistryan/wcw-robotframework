# ====================================================================================================
*** Settings ***
Documentation    Resources management for *TOP MENU* test suite.
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
Resource    imports.resource
# ====================================================================================================



# ====================================================================================================
*** Variables ***
#  Logo
${img_logoTop}    //img[@title='Wallet-Codes']

# Contact Us
${drd_contactUsTop}    //a[@class='nav-link nav-bg-overide'][normalize-space()='Contact Us']
${opt_contactUs}    //ul[@class='nav-submenu']//a[normalize-space()='Contact Us']
${opt_wcB2B}    //ul[@class='nav-submenu']//a[@id='blog']

# Products
${drd_productsTop}    //a[normalize-space()='Products']
${opt_steamProduct}    //a[@href='/id/steam-wallet-codes']
${opt_ucPUBGProduct}    //a[@href='/id/uc-pubg-mobile']
${opt_diamondMLProduct}    //a[@href='/id/mobile-legend-diamonds']
${opt_shellGarenaProduct}    //a[@href='/id/garena-shells']
${opt_pointblankProduct}    //a[@href='/id/point-blank-pb-cash-zepetto']
${opt_ayodanceIDProduct}    //a[@href='/id/megaxus-mi-cash-voucher']
${opt_googleplayGiftProduct}    //a[@href='/id/google-play-gift-card']
${opt_robloxProduct}    //a[@href='/id/roblox-gift-cards']
${opt_robloxTWProduct}    //a[@href='/tw/roblox-gift-cards']
${opt_freefireIDProduct}    //a[@href='/id/free-fire-diamonds']
${opt_lifeafterIDProduct}    //a[@href='/id/lifeafter-credits']
${opt_testCodesProduct}    //a[@href='/id/test-codes']
${opt_ragnarokBCCIDProduct}    //a[@href='/id/ragnarok-bcc']
${opt_psnIDProduct}    //a[@href='/id/psn-cards-id']    #Staging
${opt_psnIDProduct2}    //a[@href='/id/psn-card']    #Preprod
${opt_ragnarokZennyIDProduct}    //a[@href='/id/ragnarok-zeny']
${opt_lordsmobileIDProduct}    //a[@href='/id/lords-mobile-diamonds']
${opt_saintseiyaIDProduct}    //a[@href='/id/saint-seiya-awakening']    # Staging
${opt_saintseiyaIDProduct2}    //a[@href='/id/saint-seiya-awakening-coupons']    # Preprod
${opt_garenaTWProduct}    //a[@href='/tw/garena-shells-tw']
${opt_mobileLegendsTW}    //a[@href='/tw/mobile-legend-diamonds']

# Blog
${btn_blogTop}    //a[text()='Blog']     
${btn_blogTopTW}    //a[normalize-space()='blog']     

# Registration and Login
${btn_registerTop}    //ul[@class='nav-menu nav-bg-overide']//a[@class='nav-link nav-bg-overide'][normalize-space()='register']
${btn_registerTop2}    //ul[@class='nav-menu nav-bg-overide']//a[@class='nav-link nav-bg-overide'][normalize-space()='Register']
${btn_registerTopTW}    //ul[@class='nav-menu nav-bg-overide']//a[@class='nav-link nav-bg-overide'][contains(text(),'註冊')]
${btn_loginTop}    //ul[@class='nav-menu nav-bg-overide']//a[@class='nav-link nav-bg-overide pr-4'][normalize-space()='login']
${btn_loginTop2}    //ul[@class='nav-menu nav-bg-overide']//a[@class='nav-link nav-bg-overide pr-4'][normalize-space()='Login']    # Production
${btn_loginTopTW}    //ul[@class='nav-menu nav-bg-overide']//a[@class='nav-link nav-bg-overide pr-4'][contains(text(),'登入')]

# My P Points
${drd_mypPointsTop}    //a[@class='nav-link nav-bg-overide'][normalize-space()='My P Points']
${drd_myPointsTop}    //a[@class='nav-link nav-bg-overide'][normalize-space()='My Points']
${opt_redeemHistory}    //a[normalize-space()='Redeem and History']
${opt_dailyRewards}    //a[normalize-space()='Daily Rewards']

# My Accounts
${drd_myAccountsTop}    //a[@class='nav-link nav-bg-overide'][normalize-space()='My Account']
${opt_myAccounts}    //ul[@class='nav-submenu']//a[normalize-space()='My Account']
${opt_transactionHistory}    //ul[@class='nav-menu nav-bg-overide']//a[normalize-space()='Transaction History']
${opt_logout}    //ul[@class='nav-menu nav-bg-overide']//a[normalize-space()='Logout']

# Language Translation
${drd_language}    //img[@title='Languages']
${opt_idLanguage}    //span[normalize-space()='Indonesian']
${opt_enLanguage}    //span[text()="English-ID"]
# ====================================================================================================