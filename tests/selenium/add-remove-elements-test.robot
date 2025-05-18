*** Settings ***
Library       SeleniumLibrary
Variables    ../../resources/variables.py
Resource    ../../resources/browser_keywords.robot
Resource    ../../resources/add-remove-elements-page.robot
Test Setup    Open Browser In Incognito Mode    ${URL}
Test Teardown    Close Browser


*** Test Cases ***

Add remove elements test
    [Documentation]    Launch Chrome in incognito and test add remove elements
    Go To    ${URL}/add_remove_elements/
    Wait Until Element is Visible   xpath=//button[text()='Add Element']   10s
    Click Element    xpath=//button[text()='Add Element']
    Wait Until Element Is Visible    xpath=//button[text()='Delete']   10s
    Element Should Be Visible    xpath=//button[text()='Delete']
    Click Element    xpath=//button[text()='Delete']
    Wait Until Element Is Not Visible    xpath=//button[text()='Delete']   10s
    Double Click Element    locator=xpath=//button[text()='Add Element']
    Wait Until Element Is Visible    xpath=//button[text()='Delete']   10s
    ${result}=    Get Element Count    xpath=//button[text()='Delete']
    Should Be Equal As Integers    ${result}    2

Add remove elements test with Page Object
    [Documentation]    Launch Chrome in incognito and test add remove elements with Page Object
    Go To    ${URL}/add_remove_elements/
    Add Element
    ${delete_button_count}=    Get Delete Button Count
    Should Be Equal As Integers    ${delete_button_count}    1
    Remove Element
    ${delete_button_count}=    Get Delete Button Count
    Should Be Equal As Integers    ${delete_button_count}    0
    Add Element
    Add Element
    ${delete_button_count}=    Get Delete Button Count
    Should Be Equal As Integers    ${delete_button_count}    2
        
