*** Settings ***
Library    SeleniumLibrary
Library    venv/lib/python3.13/site-packages/robot/libraries/XML.py

Test Setup    Open Browser In Incognito Mode    ${URL}              
Test Teardown    Close Browser

*** Variables ***
${URL}      https://www.saucedemo.com/
${username}     standard_user
${password}     secret_sauce


*** Keywords ***
Open Browser In Incognito Mode
    [Documentation]    Open Chrome in incognito mode
    [Arguments]    ${url}
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${options}    add_argument    --incognito
    Create WebDriver    Chrome    options=${options}
    Go To    ${url}
    Maximize Browser Window
    Wait Until Element is Visible   id=user-name    10s

*** Test Cases ***
Login to sauce demo with valid credentials
    [Documentation]    Launch Chrome in incognito and login to Sauce Demo
    Input Text  id=user-name    ${username}
    Input Password  id=password     ${password}
    Click Button    id=login-button
    Wait Until Page Contains Element    xpath=//span[text()='Products']     10s
    Page Should Contain     Products


Login to sauce demo with invalid Password
    [Documentation]    Launch Chrome in incognito and login to Sauce Demo with invalid password
    Input Text  id=user-name    ${username}
    Input Password  id=password     invalid_password
    Click Button    id=login-button
    Wait Until Page Contains Element    xpath=//h3[text()='Epic sadface: Username and password do not match any user in this service']     10s
    Page Should Contain     Epic sadface: Username and password do not match any user in this service


Login to sauce demo with blank username and blank password
    [Documentation]    Launch Chrome in incognito and login to Sauce Demo with blank username and blank password
    Clear Element Text    id=user-name
    Clear Element Text    id=password
    Click Button    id=login-button
    Wait Until Page Contains Element    xpath=//h3[text()='Epic sadface: Username is required']     10s
    Page Should Contain     Epic sadface: Username is required

Login to sauce demo with blank username and valid password
    ${expected_error}=    Set Variable    Epic sadface: Username is required
    [Documentation]    Launch Chrome in incognito and login to Sauce Demo with blank username and valid password
    Wait Until Element is Visible   id=user-name    10s
    Clear Element Text    locator=id=user-name
    Input Password  id=password     ${password}
    Click Button    id=login-button
    Wait Until Page Contains Element    xpath=//h3[text()='${expected_error}']     10s
    Page Should Contain      ${expected_error}

Login to sauce demo with valid username and blank password
    [Documentation]    Launch Chrome in incognito and login to Sauce Demo with valid username and blank password
    Input Text  id=user-name    ${username}
    Clear Element Text    id=password
    Click Button    id=login-button
    Wait Until Page Contains Element    xpath=//h3[text()='Epic sadface: Password is required']     10s
    Page Should Contain     Epic sadface: Password is required

Login to sauce demo to verify the case sensitivity of password
    [Documentation]    Launch Chrome in incognito and login to Sauce Demo with case sensitivity of username and password
    Input Text  id=user-name    ${username}
    Input Password  id=password     ${password}.upper()
    Click Button    id=login-button
    Wait Until Page Contains Element    xpath=//h3[text()='Epic sadface: Username and password do not match any user in this service']     10s
    Page Should Contain     Epic sadface: Username and password do not match any user in this service