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


Hover images test
    [Documentation]    Launch Chrome in incognito and test hover images
    Go To    ${URL}/hovers
    Wait Until Element is Visible   xpath=//h3[text()='Hovers']   10s
    Mouse Over    css=div.figure:nth-of-type(3)
    Wait Until Element Is Visible    xpath=//h5[text()='name: user3']
    Wait Until Element Is Visible    xpath=//h5[text()='name: user3']/following-sibling::a
    Element Text Should Be    xpath=//h5[text()='name: user3']/following-sibling::a    View profile
    
    