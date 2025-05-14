

*** Test Cases ***

Test Use of Sleep Keyword
    [Documentation]    Test Use of Sleep Keyword
    Log To Console    Will seep for five seonds before printing the next message
    Sleep    3s
    Log To Console    I woke up after 3 seconds
    Sleep    2     resason="sleep for 2 seconds"
    Log To Console    I woke up after 2 seconds
    Sleep    1 seconds
    Log To Console    I woke up after 1 seconds

