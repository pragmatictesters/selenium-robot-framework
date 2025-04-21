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
    Go To    ${URL}/dropdown
    Wait Until Element is Visible   id=dropdown    10s
    Select From List By Value    id=dropdown    1
    Page Should Contain Element   xpath=//option[@value='1' and @selected]
    Element Text Should Be    //option[@selected]    Option 1
    Select From List By Index    id=dropdown    2
    Page Should Contain Element   xpath=//option[@value='2' and @selected]
    Element Text Should Be    //option[@selected]    Option 2
    Select From List By Label    id=dropdown    Option 1
    Page Should Contain Element   xpath=//option[@value='1' and @selected]
    Element Text Should Be    //option[@selected]    Option 1
    Select From List By Label    id=dropdown    Option 2
    Page Should Contain Element   xpath=//option[@value='2' and @selected]
    Element Text Should Be    //option[@selected]    Option 2
