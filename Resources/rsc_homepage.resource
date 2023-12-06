# ====================================================================================================
*** Settings ***
Documentation    Resources management for *HOMEPAGE* test suite.
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
# Taiwan
${btn_closePopUpTW}    //img[@alt='close']

# Banner
${unq_bannerActive}    //div[@id="WC-Banners-Carousel"]/div[1]/div[@class="carousel-item active"]
${unq_firstBannerActive}    //div[@id="WC-Banners-Carousel"]/div[1]/div[1][@class="carousel-item active"]
${unq_secondBannerActive}    //div[@id="WC-Banners-Carousel"]/div[1]/div[2][@class="carousel-item active"]
${btn_previousButton}    //img[@title='prev']
${btn_nextButton}    //img[@title='next']

# Top Selling
${txt_PUBGcard}    //h3[@class='p-0 word-break'][normalize-space()='UC PUBG Mobile']
${txt_MLcard}    //h3[@class='p-0 word-break'][normalize-space()='Mobile Legends Diamonds']
${txt_PBcard}    //h3[@class='p-0 word-break'][normalize-space()='Point Blank']
${txt_GScard}    //h3[@class='p-0 word-break'][contains(text(),'Garena Shell')]
${btn_quickBuyPUBG}    //button[@id='uc-pubg-mobile-button']
${btn_quickBuyML}    //button[@id='mobile-legend-diamonds-button']
${btn_quickBuyPB}    //button[@id='point-blank-pb-cash-zepetto-button']
${btn_quickBuyGS}    //button[@id='garena-shells-tw-button']
${unq_quickBuyPUBGPage}    //h2[normalize-space()='uc-pubg-mobile']
${unq_quickBuyMLPage}    //h2[normalize-space()='mobile-legend-diamonds']
${unq_quickBuyPBPage}    //h2[normalize-space()='point-blank-pb-cash-zepetto']
${unq_quickBuyGSPage}    //h2[normalize-space()='garena-shells-tw']
${unq_topSelling}    //h2[normalize-space()='TOP SELLING']

# Products
${btn_steamWalletCard}    //a[@id='steam-wallet-codes-thumbnail']
${btn_googlePlayGiftCard}    //a[@id='google-play-gift-card-thumbnail']
${btn_googlePlayGiftCardTW}    //div[contains(@class,'overlay')]//h3[contains(text(),'Google Play Gift Cards')]
${btn_garenaShells}    //h3[normalize-space()='Garena Shells']    # Staging
${btn_garenaShells2}    //div[@class='overlay']//h3[contains(text(),'Garena Shells')]    # Preprod
${btn_lifeAfterCard}    //a[@id='lifeafter-credits-thumbnail']    # Staging
${btn_lifeAfterCard2}    //h3[normalize-space()='LifeAfter Credits']    # Preprod
${btn_saintSeiyaCard}    //a[@id='saint-seiya-awakening-thumbnail']    # Staging
${btn_saintSeiyaCard2}    //h3[normalize-space()='Saint Seiya: Awakening Coupons']    # Preprod
${btn_mobileLegends}    //div[@class='overlay']//h3[contains(text(),'Mobile Legends Diamonds')]
${opt_lineageMBlueTop}    //a[@href='/tw/lineage-m']    # Taiwan Production
${opt_mobileLegendsTop}    //a[normalize-space()='Mobile Legends Diamonds']
${unq_googleplayGiftpage2}    //h2[normalize-space()='google-play-gift-card']    # Staging
${unq_googleplayGiftpage3}    //h2[normalize-space()='Google Play Gift Card']    # Preprod
${unq_googleplayGiftpageTW}    //h2[normalize-space()='google-play-gift-cards']    # Staging
${unq_googleplayGiftpageTW2}    //h2[normalize-space()='Google Play Gift Cards']    # Preprod and Production
${unq_garenaShellsTW}    //h2[normalize-space()='garena-shells-tw']    # Staging
${unq_garenaShellsTW2}    //h2[normalize-space()='Garena Shells']    # Production
${unq_lifeafterIDPage2}    //h2[normalize-space()='lifeafter-credits']    # Staging
${unq_lifeafterIDPage3}    //h2[normalize-space()='LifeAfter Credits']    # Preprod
${unq_saintSeiyaIDpage2}    //h2[normalize-space()='saint-seiya-awakening']    # Staging
${unq_saintSeiyaIDpage3}    //h2[normalize-space()='Saint Seiya: Awakening Coupons']    # Preprod
${unq_productsOrCategories}    //h2[normalize-space()='Products']
${unq_mobileLegendsTW}    //h2[normalize-space()='mobile-legend-diamonds']
${unq_mobileLegendsTW2}    //h2[normalize-space()='Mobile Legends Diamonds']    # Production

# Wallet Codes Experience
${btn_whyWalletCodes}    //h3[normalize-space()='Why Wallet Codes?']
${txt_whyWalletCodesDesc}    //span[contains(text(),'View More To See What You Get With Us')]
${btn_pPointsDefinition}    //h3[normalize-space()='P POINTS']
${btn_pointsDefinition}    //h3[normalize-space()='POINTS']
${txt_pPointsDefinitionDesc}    //span[contains(text(),'Maximise Your Shopping Experience With Our Loyalty')]
${btn_dailyRewardsDefinition}    //h3[normalize-space()='Daily Rewards']
${txt_dailyRewardsDefinitonDesc}    //span[contains(text(),'Check-In To Wallet Codes Every Day For Exciting Rewards')]
${unq_walletCodesExperience}    //h2[normalize-space()='The Wallet Codes Experience']

# Payment Methods
${unq_paymentMethods}    //h2[normalize-space()='Flexible Payment Methods']

# Payment Methods ID
${img_paymentIDGopay}    //img[contains(@title,'ID_Gopay')]
${img_paymentIDOVO}    //img[@title='ID_OVO']
${img_paymentMasterVisa}    //img[@title='mastercard%26visa']
${img_paymentIDPPoints}    //img[@title='ppoints.svg']    # Staging and Preprod
${img_paymentIDPPoints2}    //img[@title='ppoints']    # Production
${img_paymentIDShopeepay}    //img[@title='ID_Shopeepay']
${img_paymentIDDana}    //img[@title='ID_DANA']
${img_paymentIDBCA}    //img[@title='ID_BCA']
${img_paymentIDMandiri}    //img[@title='ID_Mandiri']
${img_paymentIDBNI}    //img[@title='ID_BNI']
${img_paymentIDBRI}    //img[@title='ID_BRI']
${img_paymentIDCIMB}    //img[@title='ID_CIMB']
${img_paymentIDPermata}    //img[@title='ID_Permata']
${img_paymentIDPermata2}    //img[@title='ID_Permata.']    # Logged in
${img_paymentIDLinkAja}    //img[@title='ID_LinkAja']
${img_paymentIDAlfamart}    //img[@title='ID_Alfamart']

# Payment Methods TW
${img_paymentTWTaiwanMobile}    //img[@title='TW_TaiwanMobile']
${img_paymentTWTStar}    //img[@title='TW_TaiwanStarTelecom']
${img_paymentTWChungHwa}    //img[@title='TW_ChunghwaTelecom']
${img_paymentTW7elevenIbon}    //img[@title='TW_7eleven&ibon']
${img_paymentTWAsiaPasificTelecom}    //img[@title='TW_AsiaPacificTelecom']
${img_paymentTWFET}    //img[@title='TW_FET']
${img_paymentTWFamiPort}    //img[@title='TW_FamiPort']
${img_paymentTWVirtualATM}    //img[@title='TW_VirtualATM']

# P Points
${btn_learnAboutPPoints}    //div[@class='p-2']/p[1]/a[contains(text(),'learn more about P Points')]
${btn_learnAboutPoints}    //div[@class='p-2']/p[1]/a[contains(text(),'learn more about Points')]

# Footer
${img_logoFooter}    //img[@class='img-fluid']
${btn_facebook}    id:facebook    # Used for Indonesia and Philippines
${btn_instagram}    id:instagram
${btn_linkedin}    id:linkedin
${btn_youtube}    id:youtube
${drd_countriesList}    id:WC_Countries
${opt_countryMY}    //span[normalize-space()='Malaysia']
${opt_countryMM}    //span[normalize-space()='Myanmar']
${opt_countryTW}    //span[normalize-space()='Taiwan']
${opt_countryPH}    //span[normalize-space()='Philippines']
${opt_countryTH}    //span[normalize-space()='Thailand']
${opt_countryID}    //span[normalize-space()='Indonesia']
${btn_playStore}    //img[@title='safe browsing']
${unq_nowAvailable}    //h4[normalize-space()='Now Available']

# Footer - Quick Links
${unq_quickLinks}    //h4[normalize-space()='Quick Links']
${btn_quickHome}    id:home
${btn_quickWhyWalletCodes}    id:why-wallet-codes
${btn_quickBlog}    //a[normalize-space()='Blog']
${btn_quickWCB2B}    //footer//a[@target='_blank'][normalize-space()='WC B2B']
${btn_quickBulkPurchase}    //footer[@id='footer-content']//a[contains(.,'Bulk Purchase')]    # Preprod TW
${btn_quickBulkPurchase2}    //footer//a[@target='_blank'][text()='Bulk purchase']    # Production TW

# Footer - Support
${unq_support}    //h4[normalize-space()='Support']
${btn_supportSupport}    id:support
${btn_terms&conditionSupport}    id:terms-and-condition
${btn_privacy&policySupport}    id:privacy-and-policy
${btn_supportContactUs}    id:contact-us

# Footer - Award
${unq_awards}    //h4[normalize-space()='Awards']
${btn_awardsAPSA}    //img[@title='APSA']
${btn_awardsACA}    //img[@title='ACA']

# Playstore Page
${unq_playstoreWC}    /html[1]/body[1]/c-wiz[2]/div[1]/div[1]/div[2]/div[1]/div[1]/div[1]/c-wiz[1]/div[2]/div[1]/div[1]/h1[1]/span[text()='Katalog Wallet Codes']
# ====================================================================================================