*** Settings ***
Library	SeleniumLibrary

*** Variables ***
${login_button}    //button[@id='dt_login_button']

*** Keywords ***
Login To Deriv
	Open Browser	https://app.deriv.com/	Chrome
	Maximize Browser Window
    Wait Until Page Contains Element     //div[@class='btn-purchase__text_wrapper' and contains(.,'Rise')]    30
    Click Element    dt_login_button    
    Wait Until Page Contains Element    //input[@type='email']    10
    Input Text    //input[@type='email']     putyouremailhere@besquare.com.my
    Input Text    //input[@type='password']    @putyourpasswordhere
    Click Element    //button[@type='submit']
    Wait Until Page Contains Element    //div[@class='btn-purchase__text_wrapper' and contains(.,'Rise')]    30
    Click Element    //div[@id='dt_core_account-info_acc-info'] 
    Click Element    //li[@id='dt_core_account-switcher_demo-tab']
    Click Element    //div[@class='dc-content-expander__content'] 

*** Test Cases ***
Login To Account
    Login To Deriv
Navigate To API Token Page
    Wait Until Page Contains Element    //a[@class="account-settings-toggle"]    30
    Sleep    10
    Click Element    //a[@class="account-settings-toggle"]
    Sleep    5
    Click Element    //a[@id="dc_api-token_link"]
Five API Token Options Are Visible
    Sleep    5
    Page Should Contain Element    //.//span[text()='Read']
    Page Should Contain Element    //.//span[text()='Trade']
    Page Should Contain Element    //.//span[text()='Payments']
    Page Should Contain Element    //.//span[text()='Trading information']
    Page Should Contain Element    //.//span[text()='Admin']
User Can Click Either One Or Multiple API Token Options
    Click Element    //.//span[text()='Read']
    Click Element    //.//span[text()='Read']
    Sleep    2
    Click Element    //.//span[text()='Trade']
    Click Element    //.//span[text()='Trade']
    Sleep    2
    Click Element    //.//span[text()='Payments']
    Click Element    //.//span[text()='Payments']
    Sleep    2
    Click Element    //.//span[text()='Trading information']
    Click Element    //.//span[text()='Trading information']
    Sleep    2
    Click Element    //.//span[text()='Admin']
    Click Element    //.//span[text()='Admin']
    Sleep    2
    Click Element    //.//span[text()='Read']
    Click Element    //.//span[text()='Trade']
    Click Element    //.//span[text()='Payments']
    Click Element    //.//span[text()='Trading information']
    Click Element    //.//span[text()='Admin']
    Sleep    2
User Validate The Token Name Field With Negative Testing 
    Click Element    //input[@name="token_name"]
    Input Text    //input[@name="token_name"]    APItokenAPItokenAPItokenAPItokenAPItoken
    Page Should Contain Element    //.//div[text()='Maximum 32 characters.']
    Press Keys    //input[@name="token_name"]    CTRL+a+BACKSPACE
    Input Text    //input[@name="token_name"]    APItoken%&
    Page Should Contain Element    //.//div[text()='Only letters, numbers, and underscores are allowed.']
    Press Keys    //input[@name="token_name"]    CTRL+a+BACKSPACE
    Input Text    //input[@name="token_name"]    Äöü
    Page Should Contain Element    //.//div[text()='Only letters, numbers, and underscores are allowed.']
    Press Keys    //input[@name="token_name"]    CTRL+a+BACKSPACE
    Input Text    //input[@name="token_name"]    我不知道
    Page Should Contain Element    //.//div[text()='Only letters, numbers, and underscores are allowed.']
    Press Keys    //input[@name="token_name"]    CTRL+a+BACKSPACE
    Input Text    //input[@name="token_name"]    A
    Page Should Contain Element    //.//div[text()='Length of token name must be between 2 and 32 characters.']
    Press Keys    //input[@name="token_name"]    CTRL+a+BACKSPACE
User Validate The Token Name Field With Positive Testing 
    Click Element    //.//span[text()='Payments']
    Click Element    //.//span[text()='Trade']
    Input Text    //input[@name="token_name"]    test_token123
    Page Should Contain Element    //button[@class="dc-btn dc-btn__effect dc-btn--primary dc-btn__large dc-btn__button-group da-api-token__button"]
    Sleep    5
User Validate Whether The Token Create Follows The API Token Chosen
    Click Element    //button[@class="dc-btn dc-btn__effect dc-btn--primary dc-btn__large dc-btn__button-group da-api-token__button"]
    Sleep    5
    Page Should Contain Element    //.//span[text()='test_token123']
    Page Should Contain Element    //.//div[text()='Read']
    Page Should Contain Element    //.//div[text()='Trading information']
    Page Should Contain Element    //.//div[text()='Admin']
User Validate If The Created API Token Can Be Copied
    Sleep    5
    Click Element    //*[contains(@data-testid, "dt_copy_token_icon")]
The Token Is Not Visible Unless The User Clicks To Show It
    Sleep    5
    Page Should Contain Element    //div[@class="da-api-token__pass-dot-container"]
    Click Element    //button[@class="dc-btn dc-btn__effect dc-btn--primary dc-btn__large dc-dialog__button"]
    Click Element    //*[contains(@data-testid, "dt_toggle_visibility_icon")]
Delete The API Token
    Sleep    3
    Click Element    //*[contains(@class, "dc-icon dc-clipboard da-api-token__delete-icon")]
    Click Element    //button[@class="dc-btn dc-btn__effect dc-btn--secondary dc-btn__large dc-dialog__button"]
    Sleep    2
    Click Element    //*[contains(@class, "dc-icon dc-clipboard da-api-token__delete-icon")]
    Click Element    //button[@class="dc-btn dc-btn__effect dc-btn--primary dc-btn__large dc-dialog__button"]
    Sleep    5
    Page Should Not Contain Element    //.//span[text()='test_token123']
Check Whether Sharing Token Warning Is Given If User Does Not Opt For Admin Token
    Click Element    //.//span[text()='Read']
    Input Text    //input[@name="token_name"]    final_token
    Click Element    //button[@class="dc-btn dc-btn__effect dc-btn--primary dc-btn__large dc-btn__button-group da-api-token__button"]
    Sleep    5
    Page Should Not Contain    //div[@class="dc-modal-body"]
    Click Element    //*[contains(@class, "dc-icon dc-clipboard da-api-token__delete-icon")]
    Click Element    //button[@class="dc-btn dc-btn__effect dc-btn--primary dc-btn__large dc-dialog__button"]
