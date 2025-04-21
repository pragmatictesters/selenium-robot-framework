*** Settings ***
Library   SeleniumLibrary
Test Template   Invalid User Login

Test Setup   Open Browser In Incognito Mode    ${URL}
Test Teardown   Close Browser


*** Variables ***
${URL}      https://www.saucedemo.com/
${username}     standard_user
${password}     secret_sauce
${invalid_password}     invalid_password
${invalid_username}     invalid_user
${blank_password}     ${EMPTY}
${blank_username}     ${EMPTY}


*** Test Cases ***
Use login with invalid password    ${username}    ${invalid_password}    Epic sadface: Username and password do not match any user in this service
Use login with blank username and blank password    ${blank_username}    ${blank_password}    Epic sadface: Username is required
Use login with blank username and valid password    ${blank_username}    ${password}    Epic sadface: Username is required
Use login with valid username and blank password    ${username}    ${blank_password}    Epic sadface: Password is required
Use login with invalid username and valid password    ${invalid_username}    ${password}    Epic sadface: Username and password do not match any user in this service

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


Invalid User Login
    [Documentation]    Launch Chrome in incognito and login to Sauce Demo
    [Arguments]    ${username}    ${password}    ${expected_error}
    Input Text  id=user-name    ${username}
    Input Password  id=password     ${password}
    Click Button    id=login-button
    Wait Until Page Contains Element    xpath=//h3[text()='${expected_error}']     10s
    Page Should Contain     ${expected_error}

