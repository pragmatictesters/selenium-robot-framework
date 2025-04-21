*** Settings ***
Library       SeleniumLibrary

*** Variables ***
${hot-spot}    id=hot-spot


*** Keywords ***

Open Content Menu in Hot Spot    
    [Documentation]   Open context menu in the hot spony
    Open Context Menu    ${hot-spot}

Get Message in Alert    
    [Documentation]    Get Message from the Alert
    ${message}=    Handle Alert   LEAVE
    Log To Console    ${message}
    RETURN    ${message}

Close Alert
    [Documentation]    Close the Alert
    Handle Alert   ACCEPT
    Log To Console    Alert closed