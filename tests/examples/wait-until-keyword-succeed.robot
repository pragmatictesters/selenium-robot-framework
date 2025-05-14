

*** Test Cases ***
Test failure of Wait Until Keyword Succeed 
    [Documentation]    Wait until a keyword succeeds
    ${result}=    Wait Until Keyword Succeeds    3x    1s    Should Be True    FASE
    Log To Console    ${result}

Test success of Wait Until Keyword Succeed 
    [Documentation]    Wait until a keyword succeeds
    ${result}=    Wait Until Keyword Succeeds    3x    1s    Should Be True    True
    Log To Console    Result is ${result}

