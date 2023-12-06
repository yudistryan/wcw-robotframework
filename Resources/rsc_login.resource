# ====================================================================================================
*** Settings ***
Documentation    Resources management for *LOGIN* and *FORGOT PASSWORD* test suite.
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
# ====================================================================================================



# ====================================================================================================
*** Variables ***
# Login page
${unq_loggedIn}    //div[@class='Toastify']/div[1]/div[1]/div[contains(text(),"Logged in Successfully")]
${err_emptyFieldsLogin}    //div[@role='alert'][text()="Required fields are empty"]
${err_cannotEmptyFieldsLogin}    //div[@role='alert'][text()="Fields cannot be empty"]
${err_invalidCredentials}    //div[@role='alert'][text()="Invalid Email or Password"]    # Staging and Preprod
${err_invalidCredentials2}    //div[@role='alert'][text()="Invalid email or password"]    # Production
${err_invalidCredentialsTW}    //div[@role='alert'][text()="Invalid Email or Password."]    # Staging and Preprod
${err_unverifiedCredentials}    //div[@role='alert'][text()="User is Not Confirmed Yet, Please Confirm Your Email."]
${btn_tryAgainLogin}    //button[@id='try-again-button']
${btn_whatIsPpointLogin}    //a[normalize-space()='What is P Points?']
${btn_whatIsPpointLoginTW}    //a[normalize-space()='What is P Point?']
${btn_forgetPasswordLogin}    //a[normalize-space()='Forget Password?']
${btn_forgetPasswordLogin2}    //a[normalize-space()='Forgot Password?']    # Production
${err_requiredPasswordLogin}    //span[normalize-space()='Password is required']
${err_invalidEmailLogin}    //span[normalize-space()='Invalid Email']
${err_invalidPasswordLogin}    //span[normalize-space()='Invalid Password']
${err_unverifyRecaptcha}    //div[@role='alert'][normalize-space()='Verify yourself via Captcha.']
${inp_emailLogin}    id:email
${inp_passwordLogin}    id:password
${btn_submitLogin}    id:login-button
${btn_facebookLogin}    //img[@alt='Facebook']
${btn_googleLogin}    //img[@alt='Google']
${btn_steamLogin}    //img[@alt='Steam']
${btn_signMeUpLogin}    //button[normalize-space()='SIGN ME UP']

# Forgot Password
${unq_forgotPassword}    //h3[normalize-space()='Forget Password?']
${unq_successForgotPassword}    //label[normalize-space()='Please Check Your Email']
${btn_submitForgotPassword}    //button[normalize-space()='Submit'] | //button[normalize-space()='PLEASE TRY AGAIN']
${btn_tryAgainForgotPassword}    //button[normalize-space()='PLEASE TRY AGAIN']
# ====================================================================================================