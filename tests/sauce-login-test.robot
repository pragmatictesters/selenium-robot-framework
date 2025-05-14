*** Settings ***
Library    SeleniumLibrary
Library    ../venv/lib/python3.13/site-packages/robot/libraries/String.py
Variables    ../resources/variables.py
Resource    ../resources/browser_keywords.robot

Test Setup    Custom Test Setup        
Test Teardown    Close Browser


*** Variables ***
${USERNAME_FIELD}    id=user-name
${PASSWORD_FIELD}    id=password
${LOGIN_BUTTON}    id=login-button


*** Keywords ***
Custom Test Setup
    [Documentation]    Custom test setup to open browser in incognito mode
    Open Browser In Incognito Mode    ${SAUCE_URL}
    Go To    ${SAUCE_URL}
    Wait Until Element is Visible   id=user-name    ${TIMEOUT}     

verify Login Error 
    [Documentation]    Verify login error message
    [Arguments]    ${expected_error} 
    ${actual_error}=    Get Text    css=[data-test="error"]
    Should Be Equal As Strings    ${expected_error}    ${actual_error}


*** Test Cases ***
Login to sauce demo with valid credentials
    [Documentation]    Launch Chrome in incognito and login to Sauce Demo
    Input Text  ${USERNAME_FIELD}   ${username}
    Input Password  ${PASSWORD_FIELD}     ${password}
    Click Button    ${LOGIN_BUTTON}
    Wait Until Page Contains Element    xpath=//span[text()='Products']     ${TIMEOUT}
    Page Should Contain     Products


Login to sauce demo with invalid Password
    [Documentation]    Launch Chrome in incognito and login to Sauce Demo with invalid password
    Input Text  ${USERNAME_FIELD}   ${username}
    Input Password  ${PASSWORD_FIELD}     invalid_password
    Click Button    ${LOGIN_BUTTON}
    verify Login Error    Epic sadface: Username and password do not match any user in this service


Login to sauce demo with blank username and blank password
    [Documentation]    Launch Chrome in incognito and login to Sauce Demo with blank username and blank password
    Clear Element Text    ${USERNAME_FIELD}
    Clear Element Text    ${PASSWORD_FIELD}
    Click Button    ${LOGIN_BUTTON}
    verify Login Error    Epic sadface: Username is required

Login to sauce demo with blank username and valid password
    ${expected_error}=    Set Variable    Epic sadface: Username is required
    [Documentation]    Launch Chrome in incognito and login to Sauce Demo with blank username and valid password
    Wait Until Element is Visible   ${USERNAME_FIELD}    ${TIMEOUT}
    Clear Element Text    ${USERNAME_FIELD}
    Input Password  ${PASSWORD_FIELD}     ${password}
    Click Button    ${LOGIN_BUTTON}
    verify Login Error    ${expected_error}

Login to sauce demo with valid username and blank password
    [Documentation]    Launch Chrome in incognito and login to Sauce Demo with valid username and blank password
    Input Text  ${USERNAME_FIELD}    ${username}
    Clear Element Text    ${PASSWORD_FIELD}
    Click Button    ${LOGIN_BUTTON}
    verify Login Error    Epic sadface: Password is required

Login to sauce demo to verify the case sensitivity of password
    [Documentation]    Launch Chrome in incognito and login to Sauce Demo with case sensitivity of username and password
    Input Text  ${USERNAME_FIELD}   ${username}
    Input Password  ${PASSWORD_FIELD}    ${password.upper()}
    Click Button    ${LOGIN_BUTTON}
    verify Login Error    Epic sadface: Username and password do not match any user in this service
    Reload Page
    Page Should Not Contain Element    css=[data-test='error']
    ${password_title_case}=    Convert To Title Case    ${password}
    Input Text  ${USERNAME_FIELD}   ${username}
    Input Password  ${PASSWORD_FIELD}    ${password_title_case}.
    Click Button    ${LOGIN_BUTTON}
    verify Login Error    Epic sadface: Username and password do not match any user in this service