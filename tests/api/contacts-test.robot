*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    ../../libraries/ContactLibrary.py
Variables    ../../resources/variables.py

Resource    users-test.robot

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


Create a new contact
    [Arguments]    ${firstName}    ${lastName}    ${email}    ${password}    ${token}
    [Documentation]    Create a new user
    ${headers}=    Create Dictionary    Accept=application/json    Authorization=Bearer ${token}
    ${payload}=    Create Dictionary    
     ...    firstName=${firstName}  
     ...    lastName=${lastName}    
     ...    email=${email} 
     ...    phone=0712345678
     ...    street1=123 Main St
     ...    street2=Suite 100
     ...    city=Colombo
     ...    stateProvince=Western
     ...    postalCode=12345
     ...    country=Sri Lanka
    ${response}=    POST On Session  Session   /contacts   json=${payload}  headers=${headers}    
    ${user_data}=    Set Variable    ${response.json()}
    [RETURN]    ${user_data['_id']}



*** Test Cases ***


Create a new contact 
    [Documentation]    Create a new contact
    ${token}=    Login To The System    ${email}    ${password}
    ${headers}=    Create Dictionary    Accept=application/json    Authorization=Bearer ${token}
    ${payload}=    Create Dictionary    
     ...    firstName=Janesh  
     ...    lastName=Kodikara
     ...    birthdate=1990-01-01
     ...    email=${email} 
     ...    phone=0712345678
     ...    street1=123 Main St
     ...    street2=Suite 100
     ...    city=Colombo
     ...    stateProvince=Western
     ...    postalCode=12345
     ...    country=Sri Lanka
    ${response}=    POST On Session  Session   /contacts   json=${payload}  headers=${headers}
    Should Be Equal As Numbers    ${response.status_code}    201
    ${user_data}=    Set Variable    ${response.json()}
    Log To Console    ${response.json()}
    Should Be Equal    ${user_data['firstName']}    ${payload}[firstName]
    Should Be Equal    ${user_data['lastName']}    ${payload}[lastName]
    Should Be Equal    ${user_data['email']}    ${payload}[email]    ignore_case=True
    Should Be Equal    ${user_data['phone']}    ${payload}[phone]
    Should Be Equal    ${user_data['street1']}    ${payload}[street1]       
    Should Be Equal    ${user_data['street2']}    ${payload}[street2]
    Should Be Equal    ${user_data['city']}    ${payload}[city]
    Should Be Equal    ${user_data['stateProvince']}    ${payload}[stateProvince]
    Should Be Equal    ${user_data['postalCode']}    ${payload}[postalCode]
    Should Be Equal    ${user_data['country']}    ${payload}[country]
    Should Be Equal    ${user_data['birthdate']}    ${payload}[birthdate] 


Create a new contact with random data 
    [Documentation]    Create a new contact with random data
    ${random_number}=    Evaluate    random.randint(10000, 10000000)    modules=random
    ${firstName_new_contact}=    Set Variable    Janesh${random_number}
    ${lastName_new_contact}=    Set Variable    Kodikara${random_number}
    ${token}=    Login To The System    ${email}    ${password}
    ${id}=    Create a new contact    ${firstName_new_contact}    ${lastName_new_contact}    ${email}    ${password}    ${token}


Delete a contact
    [Documentation]    Delete a contact
    ${random_number}=    Evaluate    random.randint(10000, 10000000)    modules=random
    ${firstName_new_contact}=    Set Variable    Janesh${random_number}
    ${lastName_new_contact}=    Set Variable    Kodikara${random_number}
    ${token}=    Login To The System    ${email}    ${password}
    ${headers}=    Create Dictionary    Accept=application/json    Authorization=Bearer ${token}
    ${id}=    Create a new contact    ${firstName_new_contact}    ${lastName_new_contact}    ${email}    ${password}    ${token}
    ${response}=    DELETE On Session  Session   /contacts/${id}   headers=${headers}
    Should Be Equal As Numbers    ${response.status_code}    200
    Should Be Equal As Strings    ${response.reason}    OK
    
