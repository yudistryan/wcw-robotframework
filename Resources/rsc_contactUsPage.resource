# ====================================================================================================
*** Settings ***
Documentation    Resources management for *CONTACT US* test suite.
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
# Send Message Form page
${inp_firstName}    id:fname
${inp_lastName}    id:last-name
${inp_phoneNumberContactUs}    name:phone
${inp_emailContactUs}    id:email
${drd_inquiry}    name:inquiry
${opt_feedback}    //option[@value='Feedback']
${opt_partnership}    //option[@value='Partnership']
${opt_sponsorship}    //option[@value='Sponsorship']
${inp_messageContactUs}    //textarea[@id='exampleFormControlTextarea1']
${btn_submitMessage}    //button[normalize-space()='Send Your Message']
${unq_recaptchaContactUs}    //iframe[@title='reCAPTCHA']
${err_emptyFieldsContactUs}    //div[@role='alert'][normalize-space()='Fields cannot be empty']
${err_unverifyRecaptchaContactUs}    //div[@role='alert'][normalize-space()='Verify yourself via Captcha.']
${unq_successSubmitContactUs}    //div[@role='alert'][normalize-space()='Your inquiry has been sent successfully']
${err_invalidEmailContactUs}    //span[normalize-space()='Invalid Email']
# ====================================================================================================