*** Settings ***
Library       SeleniumLibrary

*** Variables ***
${column_a}    id=column-a
${column_b}    id=column-b


*** Keywords ***
Drag And Drop Left to Right
    [Documentation]    Drag and drop element from left to right
    Drag And Drop Elements   ${column_a}    ${column_b}

Drag And Drop Right to Left
    [Documentation]    Drag and drop element from right to left
    Drag And Drop Elements   ${column_b}    ${column_a}

Drag And Drop Elements
    [Documentation]    Drag and drop element from one location to another
    [Arguments]    ${source}    ${target}
    ${source_element}=    Get WebElement    ${source}
    ${target_element}=    Get WebElement    ${target}
    Drag And Drop    ${source_element}    ${target_element}

Get Text In Right Column
    [Documentation]    Get text in right column
    ${text}=    Get Text    ${column_b}
    Log To Console    ${text}
    RETURN    ${text}

Get Text In Left Column
    [Documentation]    Get text in left column
    ${text}=    Get Text    ${column_a}
    Log To Console    ${text}
    RETURN    ${text}