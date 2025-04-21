*** Settings ***
Library       SeleniumLibrary
Variables     ../resources/variables.py
Resource     ../resources/dropdown-list-page.robot
Resource     ../resources/browser_keywords.robot
Test Setup    Open Browser In Incognito Mode    ${URL}
Test Teardown    Close Browser


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

Dropdown list test with Page Object 
    [Documentation]    Launch Chrome in incognito and test dropdown list with Page Object
    Go To    ${URL}/dropdown
    Select Option By Label    Option 2
    ${selected_option}=    Get Selected Option
    Should Be Equal As Strings    ${selected_option}    Option 2
    Select Option By Value    1
    ${selected_option}=    Get Selected Option
    Should Be Equal As Strings    ${selected_option}    Option 1
    Select Option By Index    2
    ${selected_option}=    Get Selected Option
    Should Be Equal As Strings    ${selected_option}    Option 2
