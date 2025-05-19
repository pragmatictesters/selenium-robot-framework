*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    ../../libraries/ContactLibrary.py
Variables    ../../resources/variables.py


*** Variables ***
${BASE_URL}    ${API_URL}
${login_endpoint}    /users/login
${email}    janesh@test.com
${password}    Test-4321   
${domain}    test.com


*** Keywords ***
Login To The System
    [Arguments]    ${email}    ${password}
    [Documentation]    Login to the system
    Create Session    Session   ${BASE_URL}
    ${headers}=    Create Dictionary    Accept=application/json
    ${payload}=    Create Dictionary    email=${email}    password=${password}
    ${response}=    POST On Session  Session   ${login_endpoint}   headers=${headers}   json=${payload}
    ${user_data}=    Set Variable    ${response.json()}
    ${token}=    Set Variable    ${user_data}[token]
    [RETURN]    ${token}

Crearte a new user
    [Arguments]    ${firstName}    ${lastName}    ${email}    ${password}    ${token}
    [Documentation]    Create a new user
    ${headers}=    Create Dictionary    Accept=application/json    Authorization=Bearer ${token}
    ${payload}=    Create Dictionary    
     ...    firstName=${firstName}  
     ...    lastName=${lastName}    
     ...    email=${email} 
     ...    password=${password}
    ${response}=    POST On Session  Session   /users   json=${payload}  headers=${headers}    
    ${user_data}=    Set Variable    ${response.json()}
    [RETURN]    ${user_data['user']['_id']}

Crearte a new user with constact library
    [Arguments]    ${token}
    [Documentation]    Create a new user with constact library
    ${headers}=    Create Dictionary    Accept=application/json    Authorization=Bearer ${token}
    ${random_contact}=    Generate Random Contact
    Log To Console    message: ${random_contact}
    ${payload}=    ${random_contact}
    ${response}=    POST On Session  Session   /users   json=${payload}  headers=${headers}    
    ${user_data}=    Set Variable    ${response.json()}
    [RETURN]    ${user_data['user']['_id']}

*** Test Cases ***

Login to the system 
    [Documentation]    Login to the system
    Create Session    Session   ${BASE_URL}
    ${headers}=    Create Dictionary    Accept=application/json
    ${payload}=    Create Dictionary    email=${email}    password=${password}
    ${response}=    POST On Session  Session   ${login_endpoint}   headers=${headers}   json=${payload}
    Should Be Equal As Numbers    ${response.status_code}    200
    ${user_data}=    Set Variable    ${response.json()}
    Log To Console    ${response.json()}
    ${token}=    Set Variable    ${user_data}[token]  
    Log To Console    ${token}  
    Should Be Equal    ${user_data['user']['firstName']}    Janesh
    Should Be Equal    ${user_data['user']['lastName']}    Kodikara
    Should Be Equal    ${user_data['user']['email']}    ${email}    ignore_case=True

Add a new user with random data 
    [Documentation]    Add a new user with random data
    ${random_number}=    Evaluate    random.randint(10000, 10000000)    modules=random
    ${firstName_new_user}=    Set Variable    Janesh${random_number}
    ${lastName_new_user}=    Set Variable    Kodikara${random_number}
    ${email_new_user}=    Set Variable    ${firstName_new_user}.${lastName_new_user}@${domain}
     ${payload_add_user}=    Create Dictionary    
     ...    firstName=${firstName_new_user}  
     ...    lastName=${lastName_new_user}    
     ...    email=${email_new_user} 
     ...    password=${password}

    Create Session    Session   ${BASE_URL}
    ${headers}=    Create Dictionary    Accept=application/json
    ${payload}=    Create Dictionary    email=${email}    password=${password}
    ${response}=    POST On Session  Session   ${login_endpoint}   headers=${headers}   json=${payload}
    Should Be Equal As Numbers    ${response.status_code}    200
    ${user_data}=    Set Variable    ${response.json()}
    ${token}=    Set Variable    ${user_data}[token]  
    ${headers}=    Create Dictionary    Accept=application/json    Authorization=Bearer ${token}
    ${response}=    POST On Session  Session   /users   headers=${headers}   json=${payload_add_user}    
    Should Be Equal As Numbers    ${response.status_code}    201
    Log To Console    message: ${response.json()}
    ${user_data}=    Set Variable    ${response.json()}
    Should Be Equal    ${user_data['user']['firstName']}    ${firstName_new_user}
    Should Be Equal    ${user_data['user']['lastName']}    ${lastName_new_user}
    Should Be Equal    ${user_data['user']['email']}    ${email_new_user}    ignore_case=True
    Dictionary Should Contain Key    ${user_data}    token
    Should Not Be Empty    ${user_data}[token]
    Dictionary Should Not Contain Key    ${user_data}    password    
    Should Not Be Empty    ${user_data['user']['_id']}


Add a new user with login keyword    
    [Documentation]    Add a new user with login keyword
    ${random_number}=    Evaluate    random.randint(10000, 10000000)    modules=random
    ${firstName_new_user}=    Set Variable    Janesh${random_number}
    ${lastName_new_user}=    Set Variable    Kodikara${random_number}
    ${email_new_user}=    Set Variable    ${firstName_new_user}.${lastName_new_user}@${domain}
     ${payload_add_user}=    Create Dictionary    
     ...    firstName=${firstName_new_user}  
     ...    lastName=${lastName_new_user}    
     ...    email=${email_new_user} 
     ...    password=${password}
    
    ${token}=    Login To The System   ${email}   ${password}

    ${headers}=    Create Dictionary    Accept=application/json    Authorization=Bearer ${token}
    ${response}=    POST On Session  Session   /users   headers=${headers}   json=${payload_add_user}    
    Should Be Equal As Numbers    ${response.status_code}    201
    Log To Console    message: ${response.json()}
    ${user_data}=    Set Variable    ${response.json()}
    Should Be Equal    ${user_data['user']['firstName']}    ${firstName_new_user}
    Should Be Equal    ${user_data['user']['lastName']}    ${lastName_new_user}
    Should Be Equal    ${user_data['user']['email']}    ${email_new_user}    ignore_case=True
    Dictionary Should Contain Key    ${user_data}    token
    Should Not Be Empty    ${user_data}[token]
    Dictionary Should Not Contain Key    ${user_data}    password    
    Should Not Be Empty    ${user_data['user']['_id']}


Delete a user
    [Documentation]    Delete a user
    ${random_number}=    Evaluate    random.randint(10000, 10000000)    modules=random
    ${firstName_new_user}=    Set Variable    Janesh${random_number}
    ${lastName_new_user}=    Set Variable    Kodikara${random_number}
    ${email_new_user}=    Set Variable    ${firstName_new_user}.${lastName_new_user}@${domain}
    ${token}=    Login To The System   ${email}   ${password}
    ${_id}=    Crearte a new user   ${firstName_new_user}   ${lastName_new_user}   ${email_new_user}   ${password}   ${token}
    ${headers}=    Create Dictionary    Accept=application/json    Authorization=Bearer ${token}
    ${response}=    DELETE On Session  Session   /users/${_id}   headers=${headers}
    Should Be Equal As Numbers    ${response.status_code}    200