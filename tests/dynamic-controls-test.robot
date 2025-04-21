*** Settings ***
Library       SeleniumLibrary
Test Setup    Open Browser In Incognito Mode    ${URL}
Test Teardown    Close Browser


*** Variables ***
${URL}      https://the-internet.herokuapp.com

*** Keywords ***
Open Browser In Incognito Mode
    [Documentation]    Open Chrome in incognito mode
    [Arguments]    ${url}
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${options}    add_argument    --incognito
    Create WebDriver    Chrome    options=${options}
    Maximize Browser Window

*** Test Cases ***

Dropdown List Test
    [Documentation]    Launch Chrome in incognito and test dropdown list
    Go To    ${URL}/dynamic_controls
    Wait Until Element is Visible   id=checkbox   10s
    Click Element    xpath=//button[text()='Remove']
    Wait Until Page Contains Element    xpath=//div[@id='loading' and text()='Wait for it... ' and not(@style)]
    Wait Until Page Contains Element    id=message     10s
    Page Should Contain     It's gone!
    Click Element    xpath=//button[text()='Add']
    Wait Until Page Contains Element    xpath=//div[@id='loading' and text()='Wait for it... ' and not(@style)]
    Wait Until Element Is Visible     xpath=//div[@id='loading' and text()='Wait for it... ']
    Wait Until Page Contains Element    id=message     10s
    Page Should Contain     It's back!
    Wait Until Element is Visible   id=checkbox   10s
    
