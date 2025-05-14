
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

Test Boolean Values using standard builtin keywords 
    [Documentation]    Test Boolean Values using standard builtin keywords
    ${true}=    Set Variable    True
    ${false}=    Set Variable    False
    Should Be True    ${true}
    Should Not Be True    ${false}
    Should Not Be False    ${true}
    Should Be False    ${false}
    Should Be Equal As Strings    ${true}    True
  