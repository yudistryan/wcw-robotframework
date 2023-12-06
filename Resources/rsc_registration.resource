# ====================================================================================================
*** Settings ***
Documentation    Resources management *REGISTRATION* test suite.
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
# Registration page
${inp_nameRegister}    name:name
${inp_emailRegister}    name:email
${inp_passwordRegister}    name:password
${inp_phoneNumberRegister}    name:phonenumber
${inp_DoBRegister}    name:birthdate
${btn_submitRegister}    id:register-button
${err_invalidEmailRegister}    //body[1]/div[4]/main[1]/div[1]/section[1]/div[1]/div[1]/div[1]/div[1]/div[1]/div[2]/div[1]/div[1]/div[1]/div[1]/form[1]/div[4]/span[1][text()="Validation Failed"] | //section[@id='register-page']//div[4]//span[1][text()='Validation Failed']
${err_invalidPasswordRegister}    //body[1]/div[1]/main[1]/div[1]/section[1]/div[1]/div[1]/div[1]/div[1]/div[1]/div[2]/div[1]/div[1]/div[1]/div[1]/form[1]/div[6]/span[1][text()="Validation Failed"] | //section[@id='register-page']//div[6]//span[1][text()='Validation Failed']
${err_invalidPhoneNumberRegister}    //body[1]/div[4]/main[1]/div[1]/section[1]/div[1]/div[1]/div[1]/div[1]/div[1]/div[2]/div[1]/div[1]/div[1]/div[1]/form[1]/div[8]/span[1][text()="Validation Failed"] | //section[@id='register-page']//div[8]//span[1][text()='Validation Failed']
${err_emptyEmailRegister}    //span[normalize-space()='Email is Required.']
${err_emptyPasswordRegister}    //span[normalize-space()='Password is Required.']
${err_emptyPhoneNumberRegister}    //span[normalize-space()='Phonenumber is Required.']
${err_emptyFieldRegister}    //div[@role='alert' and text()='Required fields are empty']
${err_duplicateAccount}    //div[@role='alert' and text()='User Already Exists']
${err_duplicateAccount2}    //div[@role='alert' and text()='User Already Exists.']    # Production
${btn_loginRegister}    //span[contains(text(),'Please complete your registration')]//a[normalize-space()='login']
${btn_loginRegister2}    //span[contains(text(),'Please complete your registration')]//a[normalize-space()='Login']    # Production
${btn_loginRegisterTW}    //a[normalize-space()='Login']
${btn_loginRegisterTW2}    //span[contains(text(),'Complete your registration')]//a[normalize-space()='login']    #Production
${btn_whatIsPpointRegister}    //a[normalize-space()='What is P Points?']
${btn_whatIsPpointRegisterTW}    //a[normalize-space()='What is P Point?']
# ====================================================================================================