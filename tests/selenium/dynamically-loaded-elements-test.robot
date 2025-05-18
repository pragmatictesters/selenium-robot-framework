*** Settings ***
Library       SeleniumLibrary
Library    ../venv/lib/python3.13/site-packages/robot/libraries/OperatingSystem.py
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

Test Element on page that is hidden
    [Documentation]    Launch Chrome in incognito and test hover images
    Go To    ${URL}/dynamic_loading
    Wait Until Element is Visible   link=Example 1: Element on page that is hidden  10s
    Click Link    Example 1: Element on page that is hidden
    Wait Until Element is Visible   id=start  10s
    Element Should Not Be Visible    xpath=//h4[text()='Hello World!']
    Click Button    css=#start > button
    Wait Until Element Is Visible    css=div#loading    10s
    Wait Until Element Contains    css=div#loading        Loading...    10s
    Wait Until Element Does Not Contain     css=div#loading        Loading...    10s
    Wait Until Element Is Visible    css=#finish > h4    10s
    Wait Until Element Is Visible    xpath=//h4[text()='Hello World!']
    Element Text Should Be    xpath=//h4[text()='Hello World!']    Hello World!
    Page Should Contain     Hello World!
    

Test Element on page that is not visible
    [Documentation]    Launch Chrome in incognito and test hover images
    Go To    ${URL}/dynamic_loading
    Wait Until Element is Visible   link=Example 2: Element rendered after the fact  10s
    Click Link    Example 2: Element rendered after the fact
    Should Not Exist    xpath=//h4[text()='Hello World!']
    Wait Until Element is Visible   id=start  10s
    Click Button    css=#start > button
    Wait Until Element Contains    css=div#loading        Loading...    10s
    Wait Until Element Does Not Contain     css=div#loading        Loading...    10s
    Wait Until Element Is Visible    css=#finish > h4    10s
    Wait Until Element Is Visible    xpath=//h4[text()='Hello World!']
    Element Text Should Be    xpath=//h4[text()='Hello World!']    Hello World!