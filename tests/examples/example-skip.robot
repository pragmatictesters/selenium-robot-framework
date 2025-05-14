

*** Test Cases ***

Test skip example 
    [Documentation]    Test skip example
    Log To Console    \nThis message is will be printed A1
    Skip
    Log To Console    This message WILL NOT will be printed A2

Test Skif If with conndition true 
    [Documentation]    Test Skif If with conndition true
    ${value}=  Set Variable    True
    Log To Console    \nThis message is will be printed B1
    Skip If    ${True}    This message WILL BE printed B2
    Log To Console    This message WILL NOT will be printed B3

Test Skif If with conndition false
    [Documentation]    Test Skif If with conndition false
    ${value}=  Set Variable    False
    Log To Console    \nThis message is will be printed C1
    Log To Console    This message is will be printed C2
    Skip If    ${False}    This message is NOT will be printed C3
    Log To Console    This message WILL BE printed C4