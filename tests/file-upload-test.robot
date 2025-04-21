*** Settings ***
Library       SeleniumLibrary
Test Setup    Open Browser In Incognito Mode    ${URL}
Test Teardown    Close Browser


*** Variables ***
${URL}      https://the-internet.herokuapp.com
${FILE_PATH}        /Users/janeshkodikara/Documents/training/robot-demo/test-data/mandella-worldcup.jpeg


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
    Go To    ${URL}/upload
    Wait Until Element is Visible   id=file-upload    10s
    Input Text    id=file-upload    ${FILE_PATH}
    Click Button    id=file-submit
    Wait Until Page Contains Element    xpath=//h3[text()='File Uploaded!']     10s
    Page Should Contain     File Uploaded!
    Wait Until Page Contains    mandella-worldcup.jpeg     10s
    
