*** Settings ***
Library       SeleniumLibrary

*** Variables ***
${add-button}    xpath=//button[text()='Add Element']
${delete-button}    xpath=//button[text()='Delete']


*** Keywords ***
Add Element
    [Documentation]    Add element to the page
    Click Element    ${add-button}
    Wait Until Element Is Visible    ${delete-button}   10s
Remove Element
    [Documentation]    Remove element from the page
    Click Element    ${delete-button}
    Wait Until Element Is Not Visible    ${delete-button}   10s

Get Delete Button Count
    [Documentation]    Get the count of delete buttons
    ${result}=    Get Element Count    ${delete-button}
    Log To Console    ${result}
    RETURN    ${result}