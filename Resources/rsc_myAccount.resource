# ====================================================================================================
*** Settings ***
Documentation    Resources management for *MY ACCOUNT* test suite.
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
# My Profile Page
${btn_editProfile}    //button[normalize-space()='Edit']
${txt_nameMyProfile}    //h6[contains(text(),'Name')]
${txt_numberMyProfile}    //h6[contains(text(),'Mobile Number')]
${txt_emailMyProfile}    //h6[contains(text(),'Email')]
${inp_nameMyProfile}    name:name
${inp_emailMyProfile}   name:email
${inp_passwordMyProfile}    name:password
${inp_phoneNumberMyProfile}    name:phonenumber
${btn_cancelSaveProfile}    //button[normalize-space()='CANCEL']
${btn_submitSaveProfile}    //button[normalize-space()='SAVE']
${unq_successSaveProfile}    //div[@role='alert'][text()='User Profile Edited Successfully']
${unq_successSaveProfile2}    //div[@role='alert'][text()='User Profile Edited Successfully.']    # Production
${err_invalidFieldsMyProfile}    //div[@role='alert'][text()='Validation Failed']
${err_emptyNameFieldMyProfile}    //span[normalize-space()='Name is Required.']
${err_emptyEmailFieldMyProfile}    //span[normalize-space()='Email is Required.']
${err_emptyFieldsMyProfile}    //div[@role='alert'][text()='Required fields are empty']
${err_invalidNameMyProfile}    //body[1]/div[4]/main[1]/div[1]/section[1]/div[1]/div[1]/div[1]/div[1]/div[1]/div[1]/div[1]/div[1]/div[1]/form[1]/div[2]/span[text()='Validation Failed'] | //span[normalize-space()='Validation Failed']
${err_invalidEmailMyProfile}    //body[1]/div[4]/main[1]/div[1]/section[1]/div[1]/div[1]/div[1]/div[1]/div[1]/div[1]/div[1]/div[1]/div[1]/form[1]/div[4]/span[text()='Validation Failed'] | //span[normalize-space()='Validation Failed']
${err_invalidEmailMyProfile2}    //div[@role='alert'][text()='email is invalid.']
${err_invalidPasswordMyProfile}    //body[1]/div[4]/main[1]/div[1]/section[1]/div[1]/div[1]/div[1]/div[1]/div[1]/div[1]/div[1]/div[1]/div[1]/form[1]/div[6]/span[text()='Validation Failed'] | //span[normalize-space()='Validation Failed']
${err_invalidPasswordMyProfileTW}    //body[1]/div[4]/main[1]/div[1]/section[1]/div[1]/div[1]/div[1]/div[1]/div[1]/div[1]/div[1]/div[1]/div[1]/form[1]/div[10]/span[text()='Validation Failed'] | //span[normalize-space()='Validation Failed']

# OTP page
${unq_EnterOTP}    //h1[normalize-space()='Enter OTP']
${btn_resendOTP}    //span[@id='resend-link']

# Transaction History
${unq_emptyTransactionHistory}    //img[@data-src='https://walletcodes-92f3.kxcdn.com/img/assets/utils/no-files.svg']
${btn_shopNowTransactionHistory}    //button[@class='wc-btn-primary mb-4']
${txt_invoiceColumnHeaderTrxHistory}    //th[normalize-space()='INVOICE']
${txt_dateColumnHeaderTrxHistory}    //th[normalize-space()='DATE']
${txt_productColumnHeaderTrxHistory}    //th[normalize-space()='Product']
${txt_paymentOptionColumnHeaderTrxHistory}    //th[normalize-space()='PAYMENT OPTION']
${txt_amountColumnHeaderTrxHistory}    //th[normalize-space()='AMOUNT']
${txt_paymentStatusColumnHeaderTrxHistory}    //th[normalize-space()='Payment Status']
${txt_actionColumnHeaderTrxHistory}    //th[normalize-space()='ACTION']
${txt_row1InvoiceTrxHistory}    //body[1]/div[1]/main[1]/div[1]/section[1]/div[1]/div[1]/div[1]/div[1]/table[1]/tbody[1]/tr[1]/td[1]/span
${txt_row2InvoiceTrxHistory}    //body[1]/div[1]/main[1]/div[1]/section[1]/div[1]/div[1]/div[1]/div[1]/table[1]/tbody[1]/tr[2]/td[1]/span
${txt_row1DateTrxHistory}    //body[1]/div[1]/main[1]/div[1]/section[1]/div[1]/div[1]/div[1]/div[1]/table[1]/tbody[1]/tr[1]/td[2]/span
${txt_row1ProductTrxHistory}    //tbody/tr/td[@class='product']/div[@class='heading']
${txt_row1PaymentOptTrxHistory}    //body[1]/div[1]/main[1]/div[1]/section[1]/div[1]/div[1]/div[1]/div[1]/table[1]/tbody[1]/tr[1]/td[4]/span
${txt_row1AmountTrxHistory}    //body[1]/div[1]/main[1]/div[1]/section[1]/div[1]/div[1]/div[1]/div[1]/table[1]/tbody[1]/tr[1]/td[5]/span
${txt_row1PaymentStatusTrxHistory}    //body[1]/div[1]/main[1]/div[1]/section[1]/div[1]/div[1]/div[1]/div[1]/table[1]/tbody[1]/tr[1]/td[6]/span
${txt_row1ActionTrxHistory}    //body[1]/div[1]/main[1]/div[1]/section[1]/div[1]/div[1]/div[1]/div[1]/table[1]/tbody[1]/tr[1]/td[7]/span
${btn_contactSupportTrxHistory}    //tbody/tr[1]/td[7]/button[1]    # 1st Row
${btn_contactSupportTrxHistory2nd}    //tbody/tr[2]/td[7]/button[1]    # 2nd Row
${btn_reorderTrxHistory}    //tbody/tr[1]/td[7]/button[2]    # 1st Row
${unq_reorderDenomPage}    //h2[normalize-space()='Step 1 - Select Denomination']
${txt_reorderDenomTitle}    //div[@class='page-title']/h2
# ====================================================================================================