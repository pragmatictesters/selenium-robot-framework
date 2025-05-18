*** Settings ***
Library       SeleniumLibrary
Test Setup    Open Browser In Incognito Mode    ${URL}
Test Teardown    Close Browser
Resource    ../../resources/drag-and-drop-page.robot

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

Drag and drop test 
...    [Documentation]    Drag and drop test without Page Object
    Go To    ${URL}/drag_and_drop
    Wait Until Element is Visible   id=column-a    10s
    ${source}=    Get WebElement    id=column-a
    ${target}=    Get WebElement    id=column-b
    Page Should Contain Element   xpath=//div[@id='column-a']/header[text()='A']
    Element Text Should Be    //div[@id='column-a']    A
    Element Text Should Be    //div[@id='column-b']    B
    Page Should Contain Element   xpath=//div[@id='column-b']/header[text()='B']
    Drag And Drop    ${source}    ${target}
    Page Should Contain Element   xpath=//div[@id='column-b']/header[text()='A']
    Element Text Should Be    //div[@id='column-b']    A
    Page Should Not Contain Element   xpath=//div[@id='column-a']/header[text()='A']
    Element Text Should Be    //div[@id='column-a']    B
    Page Should Contain Element   xpath=//div[@id='column-a']/header[text()='B']

Drag and drop test with Page Object
...    [Documentation]    Drag and drop test with Page Object
    Go To    ${URL}/drag_and_drop
    Drag And Drop Left to Right
    ${text-right}=    Get Text In Right Column
    ${text-left}=    Get Text In Left Column
    Should Be Equal As Strings    ${text-right}    A
    Should Be Equal As Strings    ${text-left}    B
    Drag And Drop Right to Left
    ${text-right}=    Get Text In Right Column
    ${text-left}=    Get Text In Left Column
    Should Be Equal As Strings    ${text-right}    B
    Should Be Equal As Strings    ${text-left}    A

