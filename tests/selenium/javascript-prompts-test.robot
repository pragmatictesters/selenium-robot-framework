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

Test Javascript Alert
    [Documentation]    Launch Chrome in incognito and test Javascript alert
    Go To    ${URL}/javascript_alerts
    Wait Until Element is Visible   xpath=//button[text()='Click for JS Alert']   10s
    Click Element    xpath=//button[text()='Click for JS Alert']
    ${alert_text}=   Handle Alert   LEAVE
    Alert Should Be Present    I am a JS Alert
    Should Be Equal As Strings    ${alert_text}    I am a JS Alert
    Wait Until Element Contains    xpath=//p[@id='result']    You successfully clicked an alert

Test Javascript Confirm Ok
    [Documentation]    Launch Chrome in incognito and test Javascript confirm Ok
    Go To    ${URL}/javascript_alerts
    Wait Until Element is Visible   xpath=//button[text()='Click for JS Confirm']   10s
    Click Element    xpath=//button[text()='Click for JS Confirm']
    ${alert_text}=   Handle Alert   LEAVE
    Alert Should Be Present    I am a JS Confirm    ACCEPT
    Should Be Equal As Strings    ${alert_text}    I am a JS Confirm
    Wait Until Element Contains    xpath=//p[@id='result']    You clicked: Ok

Test Javascript Confirm Cancel 
    [Documentation]    Launch Chrome in incognito and test Javascript confirm Cancel
    Go To    ${URL}/javascript_alerts
    Wait Until Element is Visible   xpath=//button[text()='Click for JS Confirm']   10s
    Click Element    xpath=//button[text()='Click for JS Confirm']
    ${alert_text}=   Handle Alert   LEAVE
    Alert Should Be Present    I am a JS Confirm    DISMISS
    Should Be Equal As Strings    ${alert_text}    I am a JS Confirm
    Wait Until Element Contains    xpath=//p[@id='result']    You clicked: Cancel

Test Javascript Prompt Ok
    [Documentation]    Launch Chrome in incognito and test Javascript prompt Ok
    Go To    ${URL}/javascript_alerts
    Wait Until Element is Visible   xpath=//button[text()='Click for JS Prompt']   10s
    Click Element    xpath=//button[text()='Click for JS Prompt']
    ${alert_text}=   Handle Alert   LEAVE
    Should Be Equal As Strings    ${alert_text}    I am a JS prompt
    Input Text Into Alert    Hello World! ACCEPT
    Wait Until Element Contains    xpath=//p[@id='result']    You entered: Hello World!

Test Javascript Prompt Cancel
    [Documentation]    Launch Chrome in incognito and test Javascript prompt Cancel
    Go To    ${URL}/javascript_alerts
    Wait Until Element is Visible   xpath=//button[text()='Click for JS Prompt']   10s
    Click Element    xpath=//button[text()='Click for JS Prompt']
    ${alert_text}=   Handle Alert   DISMISS
    Should Be Equal As Strings    ${alert_text}    I am a JS prompt
    Wait Until Element Contains    xpath=//p[@id='result']    You entered: null