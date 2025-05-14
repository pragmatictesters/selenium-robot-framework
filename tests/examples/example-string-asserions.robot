
*** Keywords ***
Should Not Be False
    [Documentation]    Verify that the value is not false
    [Arguments]    ${value}
    Should Be True  ${value}
   
Should Be False
    [Documentation]    Verify that the value is false
    [Arguments]    ${value}
    Should Not Be True  ${value}
   

*** Test Cases ***


Test Strings using standard builtin keywords 
    [Documentation]    Test Strings using standard builtin keywords
    ${string1}=    Set Variable    Hello World
    ${string2}=    Set Variable    Hello Robot Framework
    Should Start With    ${string1}    Hello
    Should Match    ${string1}    Hello World
    Should Contain    ${string1}    World
    Should Not Contain    ${string1}    Robot
    Should Not Start With    ${string1}    Robot
    Should Not Match    ${string1}    Hello Robot Framework
    Should Start With    ${string1}    hello    ignore_case=true
    Should Match    ${string1}    hello world    ignore_case=true
    Should Contain    ${string1}    Hello    world    ignore_case=true    strip_spaces=true
    Should End With    ${string2}    Framework
    Should Not End With    ${string2}    Robot
    Should Match Regexp    Foo: 42    foo: [0-4]{2}    flags=IGNORECASE
    Should Not Match Regexp    Foo: 42    foo: [a-z]+
    Should Contain Any    ${string1}    Hello    Robot
    Should Contain Any    ${string1}    hello   Robot    ignore_case=true    msg=Should contain any faiiled
    Should Not Contain Any    ${string1}    Test    Robot