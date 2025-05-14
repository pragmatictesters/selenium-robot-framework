*** Settings ***
Library    RequestsLibrary


*** Variables ***
${BASE_URL}    https://jsonplaceholder.typicode.com
@{EXPECTED_NAMES}
...    Leanne Graham
...    Ervin Howell
...    Clementine Bauch
...    Patricia Lebsack
...    Chelsey Dietrich
...    Mrs. Dennis Schulist
...    Kurtis Weissnat
...    Nicholas Runolfsdottir V
...    Glenna Reichert
...    Clementina DuBuque

*** Test Cases ***

Get User Details
    Create Session    mysession    ${BASE_URL}
    ${response}=    GET On Session   mysession    /users/1
    Should Be Equal As Numbers    ${response.status_code}    200
    ${user_data}=    Set Variable    ${response.json()}
    Log To Console    ${response.json()}
    Should Be Equal As Strings     ${user_data}[name]    Leanne Graham    
    Should Be Equal As Strings     ${user_data}[email]    Sincere@april.biz   
    Should Be Equal As Strings     ${user_data}[address][street]    Kulas Light
    ${expected_geo}=    Create Dictionary    lat=-37.3159    lng=81.1496
    ${expected_address}=    Create Dictionary    street=Kulas Light    suite=Apt. 556    city=Gwenborough    zipcode=92998-3874    geo=${expected_geo}
    Should Be Equal    ${user_data}[address]    ${expected_address}


Get User Details With Query Parameters
    [Documentation]    Get user details with query parameters
    ${user_id}=    Set Variable    1
    Create Session    mysession    ${BASE_URL}
    ${response}=    GET On Session   mysession    /users/${user_id}
    Should Be Equal As Numbers    ${response.status_code}    200
    ${user_data}=    Set Variable    ${response.json()}
    Log To Console    ${response.json()}
    Should Be Equal As Strings     ${user_data}[name]    Leanne Graham    
    Should Be Equal As Strings     ${user_data}[email]    Sincere@april.biz   
    Should Be Equal As Strings     ${user_data}[address][street]    Kulas Light
    ${expected_geo}=    Create Dictionary    lat=-37.3159    lng=81.1496
    ${expected_address}=    Create Dictionary    street=Kulas Light    suite=Apt. 556    city=Gwenborough    zipcode=92998-3874    geo=${expected_geo}
    Should Be Equal    ${user_data}[address]    ${expected_address}


Get User Details With Headers
    [Documentation]    Get user details with headers
    ${user_id}=    Set Variable    1
    Create Session    mysession    ${BASE_URL}
    ${headers}=    Create Dictionary    Accept=application/json
    ${response}=    GET On Session   mysession    /users/${user_id}   headers=${headers}
    Should Be Equal As Numbers    ${response.status_code}    200
    ${user_data}=    Set Variable    ${response.json()}
    Log To Console    ${response.json()}
    Should Be Equal As Strings     ${user_data}[name]    Leanne Graham


Test names of all the users
    [Documentation]   Test names of all the users
    Create Session    mysession    ${BASE_URL}
    ${response}=    GET On Session   mysession    /users
    Should Be Equal As Numbers    ${response.status_code}    200
    ${user_data}=    Set Variable    ${response.json()}
    Log To Console    ${response.json()}
    Should Be Equal As Strings     ${user_data}[0][name]    Leanne Graham
    Should Be Equal As Strings     ${user_data}[1][name]    Ervin Howell
    Should Be Equal As Strings     ${user_data}[2][name]    Clementine Bauch
    Should Be Equal As Strings     ${user_data}[3][name]    Patricia Lebsack
    Should Be Equal As Strings     ${user_data}[4][name]    Chelsey Dietrich
    Should Be Equal As Strings     ${user_data}[5][name]    Mrs. Dennis Schulist
    Should Be Equal As Strings     ${user_data}[6][name]    Kurtis Weissnat
    Should Be Equal As Strings     ${user_data}[7][name]    Nicholas Runolfsdottir V
    Should Be Equal As Strings     ${user_data}[8][name]    Glenna Reichert
    Should Be Equal As Strings     ${user_data}[9][name]    Clementina DuBuque


Test names of all the users using loop
    [Documentation]   Test names of all the users
    Create Session    mysession    ${BASE_URL}
    ${response}=    GET On Session   mysession    /users
    Should Be Equal As Numbers    ${response.status_code}    200
    ${user_data}=    Set Variable    ${response.json()}
    Log To Console    ${response.json()}
    FOR    ${index}    IN RANGE    len(${EXPECTED_NAMES})
        Should Be Equal As Strings    ${user_data}[${index}][name]    ${EXPECTED_NAMES}[${index}]
    END