*** Settings ***
Library       SeleniumLibrary
Variables    ../../resources/variables.py
Resource    ../../resources/browser_keywords.robot
Resource    ../../resources/context-menu-page.robot
Test Setup    Open Browser In Incognito Mode    ${URL}
Test Teardown    Close Browser


*** Test Cases ***

Test context menu 
    [Documentation]    Launch Chrome in incognito and test add remove elements
    Go To    ${URL}/context_menu
    Wait Until Element is Visible   id=hot-spot   ${TIMEOUT}
    Open Context Menu           id=hot-spot
    ${alert_text}=   Handle Alert   LEAVE 
    Alert Should Be Present    You selected a context menu 
    Should Be Equal As Strings    ${alert_text}    You selected a context menu


Test context menu with Page Object
    [Documentation]    Test context menu with Page Object
    Go To   ${URL}/context_menu
    Open Content Menu in Hot Spot
    ${alert_text}=   Get Message in Alert
    Should Be Equal As Strings    ${alert_text}    You selected a context menu
    Close Alert
    

    