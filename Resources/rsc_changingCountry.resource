# ====================================================================================================
*** Settings ***
Documentation    Resources management for *CHANGING COUNTRY* test suite.
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
# Malaysia
${opt_englishMY}    //span[@class='a-tag-btn selected_language'][text()='English-MY']
${unq_paymentMethodsMY}    //h2[normalize-space()='Flexible payment methods']    # Staging & Preprod
${unq_paymentMethodsMY2}    //h2[normalize-space()='Flexible Payment Methods']    # Production

# Myanmar
${opt_englishMM}    //span[@class='a-tag-btn '][text()='English-MM']
${opt_burmese}    //span[@class='a-tag-btn selected_language'][text()='Burmese']
${unq_paymentMethodsMM}    //h2[contains(text(),'လွယ်ကူသော ငွေပေးချေမှုနည်းလမ်းများ')]
${img_telenorMM}    //img[@title='MM_Telenor']
${img_mpuMM}    //img[@title='MM_MPU']
${img_ayapayMM}    //img[@title='MM_AyaPay']
${img_wavepayMM}    //img[@title='MM_WaveMoney']
${img_kbzpayMM}    //img[@title='MM_KBZPay']

# Philippines
${opt_englishPH}    //span[@class='a-tag-btn selected_language'][text()='English-PH']
${unq_paymentMethodsPH}    //h2[normalize-space()='Flexible Payment Methods']
${img_globePH}    //img[@title='PH_Globe']
${img_7elevenPH}    //img[@title='PH_7Eleven']
${img_gcashPH}    //img[@title='PH_GCash_White']
${img_coinsPH}    //img[@title='PH_Coins']
${img_smartPH}    //img[@title='PH_Smart']
${img_grabpayPH}    //img[@title='PH_GrabPay']
${img_bdoPH}    //img[@title='PH_DragonPayBDO']
${img_bpiPH}    //img[@title='PH_DragonPayBPIA']
${img_metrobankPH}    //img[@title='PH_DragonPayMBTC']
${img_pcaBayadPH}    //img[@title='PH_PayCashatBayad']
${img_pcaBDOPH}    //img[@title='PH_PayCashatBDO']
${img_pcaECpayPH}    //img[@title='PH_PayCashatECPay']
${img_smartTNTPH}    //img[@title='PH_Coins_Smart-TNT']

# Thailand
${opt_englishTH}    //span[normalize-space()='English-TH']
${opt_thai}    //span[@class='a-tag-btn selected_language'][text()='Thai']
${unq_paymentMethodsTH}    //h2[contains(text(),'หลากหลายช่องทางการชำระเงิน')]
${img_mixTH}    //img[@title='TH_Mix']
${img_linepayTH}    //img[@title='TH_RabbitLINEPay']
${img_inetBankingTH}    //img[@title='TH_InternetBanking']
${img_shopeepayTH}    //img[@title='TH_Shopeepay']
${img_paypalTH}    //img[@title='TH_PayPal']
${img_2c2pTH}    //img[@title='TH_2c2p']
${btn_lineFooter}    //img[@title='line']
${txt_qrCodeLineTH}    //strong[@class='title'][contains(text(),'QR code')]
${btn_closeModalLineTH}    //body[@class='popup_open']/div[1]/div[2]/div[1]/div[1]/div[1]/button[@class='button_close']
${unq_lineTHpage}    //h1[@class='profile_title'][text()='Wallet Codes']

# Taiwan
${opt_chinese}    //span[normalize-space()='Chinese']
${opt_englishTW}    //span[normalize-space()='English-TW']
${unq_homepageTWEnglish}    //h2[normalize-space()='The Wallet Codes Experience']
${unq_paymentMethodsTW}    //h2[contains(text(),'多元付款方式')]

# Indonesia
${unq_paymentMethodsID}    //h2[normalize-space()='Metode Pembayaran Yang Beragam']

# Social Media
${btn_facebookMY,MM,TH}    //img[@title='facebook']

# Payment
${img_ppointsPayment}    //img[@title='ppoints.svg']

# Language
${opt_englishWildCardSelected}    //span[contains(text(),'English')][contains(@class,'selected_language')]
${opt_englishWildCard}    //span[contains(text(),'English')]
# ====================================================================================================