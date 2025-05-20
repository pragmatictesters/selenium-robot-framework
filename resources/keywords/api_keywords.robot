*** Settings ***
Library    RequestsLibrary
Library    ../../libraries/disable_warnings.py
Library    Collections
| Library | FakerLibrary | WITH NAME | faker
Library    ../../libraries/ContactLibrary.py
Library    String

Variables    ../../resources/variables/variables_api.py


*** Keywords ***

Validate Response Status
    [Arguments]    ${response}    ${expected_status}
    Should Be Equal As Numbers    ${response.status_code}    ${expected_status}

Validate Response message
    [Arguments]    ${response}    ${expected_message}
    Should Be Equal As Strings    ${response.reason}    ${expected_message}

Login To The System
    [Arguments]    ${email}    ${password}
    [Documentation]    Login to the system
    Create Session    Session   ${API_URL}
    ${headers}=    Create Dictionary    Accept=application/json
    ${payload}=    Create Dictionary    email=${email}    password=${password}
    ${response}=    POST On Session  Session   ${login_endpoint}   headers=${headers}   json=${payload}
    ${user_data}=    Set Variable    ${response.json()}
    ${auth_token}=    Set Variable    ${response.json()['token']}
    Set Test Variable    ${token}    ${auth_token}

Logout user
    [Documentation]    Logout user
    [Arguments]    ${token}
    ${headers}=    Create Dictionary    Accept=application/json    Authorization=Bearer ${token}
    ${response}=    POST On Session  Session   /users/logout   headers=${headers}

Create a new contact
    [Arguments]    ${firstName}    ${lastName}    ${email}    ${token}
    [Documentation]    Create a new user
    ${headers}=    Create Dictionary    Accept=application/json    Authorization=Bearer ${token}
    ${payload}=    Create Dictionary    
     ...    firstName=${firstName}  
     ...    lastName=${lastName}    
     ...    email=${email} 
     ...    birthdate=1990-01-01
     ...    phone=0712345678
     ...    street1=123 Main St
     ...    street2=Suite 100
     ...    city=Colombo
     ...    stateProvince=Western
     ...    postalCode=12345
     ...    country=Sri Lanka
    ${response}=    POST On Session  Session   /contacts   json=${payload}  headers=${headers}    
    ${user_data}=    Set Variable    ${response.json()}
    Set Test Variable    ${contact_id}    ${user_data['_id']}
    RETURN    ${user_data['_id']}

Create a new contact with randon data
    [Documentation]    Create a new user with randon data
    ${headers}=    Create Dictionary    Accept=application/json    Authorization=Bearer ${token}
    ${payload}=    Generate Random Contact Payload
    ${response}=    POST On Session  Session   /contacts   json=${payload}  headers=${headers}    
    ${user_data}=    Set Variable    ${response.json()}
    Set Test Variable    ${contact_id}    ${user_data['_id']}
    RETURN    ${user_data['_id']}

Generate Random Contact Payload
    [Documentation]    Generates a contact payload using Faker and returns a dictionary
    ${firstName}=    faker.First Name
    ${lastName}=    faker.Last Name
    ${email}=    faker.Email
    ${birthdate}=    faker.Date Of Birth
    ${birthdate}=    Convert To String    ${birthdate}
    ${phone}=     Generate Random String    10    [NUMBERS]
    ${street1}=    faker.Street Address
    ${street2}=    faker.Secondary Address
    ${city}=    faker.City
    ${stateProvince}=    faker.State
    ${postalCode}=    faker.Postal Code
    ${country}=    faker.Country

    ${payload}=    Create Dictionary
    ...    firstName=${firstName}
    ...    lastName=${lastName}
    ...    birthdate=${birthdate}
    ...    email=${email}
    ...    phone=${phone}
    ...    street1=${street1}
    ...    street2=${street2}
    ...    city=${city}
    ...    stateProvince=${stateProvince}
    ...    postalCode=${postalCode}
    ...    country=${country}

    RETURN    ${payload}

Delete a contact if exists
    [Arguments]    ${contact_id}    ${token}
    [Documentation]    Delete a contact if it exists
    ${headers}=    Create Dictionary    Accept=application/json    Authorization=Bearer ${token}
    ${response}=    GET On Session    Session    /contacts/${contact_id}    headers=${headers}    expected_status=ANY
    Run Keyword If    '${response.status_code}' == '200'    DELETE On Session    Session    /contacts/${contact_id}    headers=${headers}