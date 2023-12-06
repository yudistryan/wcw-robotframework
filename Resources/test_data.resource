# ====================================================================================================
*** Settings ***
Documentation    Global test data management for all test suites.
# ====================================================================================================



# ====================================================================================================
*** Variables ***
# Environment
${url_baseID_staging}    https://staging.wallet-codes.com/id
${url_baseID_preprod}    https://preprod.wallet-codes.com/id
${url_baseID_production}    https://www.wallet-codes.com/id
${url_baseTW_staging}    https://staging.wallet-codes.com/tw
${url_baseTW_preprod}    https://preprod.wallet-codes.com/tw
${url_baseTW_production}    https://www.wallet-codes.com/tw
${checkStaging}    staging
${checkPreprod}    preprod
${checkTaiwan}    /tw
${url_usedUrl}    ${None}
${global_env}    ${None}
${disabledTCs}    ['C10016','C10017']

# Other URLs
${url_wc4b}    https://business.wallet-codes.com/home/
${url_blog}    https://blog.wallet-codes.com/
${url_firstBanner}    https://www.instagram.com/fightesportsid/?hl=en
${url_pPpointsDefinition}    https://staging.wallet-codes.com/id/support/p-points
${url_wcFacebook}    facebook.com/WalletCodesIndonesia/    # https://www.facebook.com/WalletCodesIndonesia/
${url_wcInstagram}    https://www.instagram.com/walletcodesid/
${url_wcInstagramTW}    https://www.instagram.com/walletcodestw/
${url_wcLinkedin}    https://www.linkedin.com/company/walletcodes/
${url_wcYoutube}    https://www.youtube.com/channel/UCihwPI1YB6ivjHHJqLhdbpg
${url_wcYoutubeTW}    https://www.youtube.com/channel/UC7uo3MWAOUUF2dlRWR0T-mQ/featured
${url_apsaAward}    https://asia.stevieawards.com/home
${url_acaAward}    https://www.crunchbase.com/event/asia-communication-awards-2017-2017524#section-overview
${url_playstorePage}    https://play.google.com/store/apps/details?id=com.forest_interactive.walletcodes.b2c&referrer=utm_source%3Dwebsite%26utm_medium%3Dfooter%26utm_term%3Dbutton%26utm_campaign%3Dfooter_button
${url_wcInstagramTH}    https://www.instagram.com/walletcodesth/
${url_wcFacebookTH}    facebook.com/walletcodesth/    # https://www.facebook.com/walletcodesth/
${url_wcFacebookMY}    facebook.com/WalletCodesMalaysia/    # https://www.facebook.com/WalletCodesMalaysia/
${url_wcFacebookMM}    facebook.com/walletcodesmyanmar    # https://www.facebook.com/walletcodesmyanmar
${url_wcFacebookPH}    facebook.com/WalletCodesPhilippines/    # https://www.facebook.com/WalletCodesPhilippines/
${url_wcFacebookTW}    facebook.com/WCTaiwan
${url_gmail}    https://mail.google.com/mail/u/0/#inbox

#Valid Data
${valid_name}    QA - Yudis
${valid_name2}    John Doe
${valid_name3}    QA Testing
${valid_name4}    erika taiwan
${valid_email}    test@example.com
${valid_email2}    yudis.yufanria+test@wallet-codes.com
${valid_email3}    erikaworkforest@gmail.com
${valid_email4}    yudis.yufanria+notransaction@wallet-codes.com
${valid_email5}    yudis.yufanria+taiwan@wallet-codes.com
${valid_email6}    nightenough@gmail.com
${valid_password}    Hello12!
${valid_password2}    Holla12!
${valid_password3}    Password01!
${valid_firstName}    John
${valid_lastName}    Doe
${valid_phoneNumber}    0963237246
${valid_phoneNumber2}    082131141131
${valid_phoneNumber3}    0912312312
${valid_DoB_YYYYMMDD}    01011990
${valid_userId}    811646362
${valid_zoneId}    12782
${valid_MLUsername}    sabey23

#Invalid Passwords
${invalid_password1}    Helo123    
${invalid_password2}    hello123    
${invalid_password3}    HELLO123
${invalid_password4}    12345678
${invalid_password5}    HelloHello
${invalid_password6}    H!!!1234

#Invalid Emails
${invalid_email1}    test
${invalid_email2}    @example.com
${invalid_email3}    testexample.com
${invalid_email4}    test@example
${invalid_email5}    test/test@example.com
${invalid_email6}    test@!.m
${invalid_email7}    test test@example.com
${invalid_email8}    test@example com
${registered_email}    test@wallet-codes.com
${unverified_email}    yudis100723@gmail.com
${unregistered_email}    just.someday@example.com

# Invalid Phone Numbers
${invalid_phone1}    123e45678
${invalid_phone2}    123+
${invalid_phone3}    abcdefhij
${invalid_phone4}    123!45678

# Invalid Zone and User ID
${invalid_zoneId1}    123456789
${invalid_userId1}    11111

# Promo Code
${invalid_code1}    HK73829
${invalid_code2}    HEHEHE
${invalid_code3}    1234567

# Cards
${valid_cc1}    4111
${valid_cc2}    1111
${cvc}    123
# ====================================================================================================