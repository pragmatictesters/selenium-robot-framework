*** Settings ***
Library       SeleniumLibrary

*** Variables ***
${dropdown}    id=dropdown


*** Keywords ***

Select Option By Value
    [Arguments]    ${value}
    [Documentation]    Select option from dropdown by value
    Select From List By Value    ${dropdown}    ${value}
    Log To Console    Selected option by value: ${value}

Select Option By Index
    [Arguments]    ${index}
    [Documentation]    Select option from dropdown by index
    Select From List By Index    ${dropdown}    ${index}
    Log To Console    Selected option by index: ${index}

Select Option By Label
    [Arguments]    ${label}
    [Documentation]    Select option from dropdown by label
    Select From List By Label    ${dropdown}    ${label}
    Log To Console    Selected option by label: ${label}

Get Selected Option
    [Documentation]    Get the selected option from dropdown
    ${selected_option}=    Get Selected List Label    ${dropdown}
    Log To Console    Selected option: ${selected_option}
    RETURN    ${selected_option}