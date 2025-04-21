*** Settings ***
Library       SeleniumLibrary
Test Setup    Open Browser In Incognito Mode    ${URL}
Test Teardown    Close Browser


*** Variables ***
${URL}      https://the-internet.herokuapp.com
${TAB_KEY}    \\09
${ENTER_KEY}    \\13
${SLASH_KEY}    \\47
${BACK_QUOTE_KEY}    \\96
${SHIFT_KEY}    \\10

*** Keywords ***
Open Browser In Incognito Mode
    [Documentation]    Open Chrome in incognito mode
    [Arguments]    ${url}
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${options}    add_argument    --incognito
    Create WebDriver    Chrome    options=${options}
    Maximize Browser Window

*** Test Cases ***

Key press test
    [Documentation]    Launch Chrome in incognito and test dropdown list
    Go To    ${URL}/key_presses
    Wait Until Element is Visible   id=target   10s
    Press Key    id=target    a
    Wait Until Page Contains Element    xpath=//p[text()='You entered: A']     10s
    Page Should Contain     You entered: A
    Press Key    id=target      `
    Wait Until Page Contains Element    xpath=//p[text()='You entered: BACK_QUOTE']     10s
    Page Should Contain     You entered: BACK_QUOTE
    Press Key    id=target    .
    Wait Until Page Contains Element    xpath=//p[text()='You entered: PERIOD']     10s
    Page Should Contain     You entered: PERIOD
    Press Key    id=target    /
    Wait Until Page Contains Element    xpath=//p[text()='You entered: SLASH']     10s
    Page Should Contain     You entered: SLASH
    Click Element    id=target
    Press Key    id=target    ${ENTER_KEY}
    Wait Until Page Contains Element    xpath=//p[text()='You entered: ENTER']     10s
    Page Should Contain     You entered: ENTER
    Press Key    id=target    ${TAB_KEY}
    Wait Until Page Contains Element    xpath=//p[text()='You entered: TAB']     10s
    Page Should Contain     You entered: TAB
    