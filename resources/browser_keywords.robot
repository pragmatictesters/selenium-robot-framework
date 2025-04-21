*** Settings ***
Library       SeleniumLibrary
Variables    ../resources/variables.py

*** Keywords ***

*** Keywords ***
Open Browser In Incognito Mode
    [Documentation]    Open Chrome in incognito mode without the info bar
    [Arguments]    ${url}
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${options}    add_argument    --incognito
    Call Method    ${options}    add_argument    --disable-infobars
    Create WebDriver    ${BROWSER}    options=${options}
    Maximize Browser Window
