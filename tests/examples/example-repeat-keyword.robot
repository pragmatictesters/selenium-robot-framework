*** Variables ***
${repeat_count}=    2

*** Test Cases ***
Test repeat example 
    [Documentation]    Test repeat example
    Log To Console    \nThis message is will be printed A1
    Repeat Keyword    2 times    Log To Console    This message is repeated 1
    Repeat Keyword    ${repeat_count}    Log To Console    This message is repeated 2
    Repeat Keyword    1 s    Log To Console    This message is repeated for five seconds 3