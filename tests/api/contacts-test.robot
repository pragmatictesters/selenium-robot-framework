*** Settings ***
Library    RequestsLibrary
Library    Collections
| Library | FakerLibrary | WITH NAME | faker
Library    ../../libraries/ContactLibrary.py
Library    String
Variables    ../../resources/variables.py
Test Setup    Login To The System    ${email}    ${password}
Test Teardown    Run Keywords    Delete a contact if exists    ${contact_id}    ${token}    AND    Logout user    ${token}


*** Variables ***
${BASE_URL}    ${API_URL}
${login_endpoint}    /users/login
${email}    janesh@test.com
${password}    Test-4321   
${domain}    test.com
${token}    ${None}
${contact_id}    ${None}


*** Keywords ***
Login To The System
    [Arguments]    ${email}    ${password}
    [Documentation]    Login to the system
    Create Session    Session   ${BASE_URL}
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
    [RETURN]    ${user_data['_id']}

Create a new contact with randon data
    [Documentation]    Create a new user with randon data
    ${headers}=    Create Dictionary    Accept=application/json    Authorization=Bearer ${token}
    ${payload}=    Generate Random Contact Payload
    ${response}=    POST On Session  Session   /contacts   json=${payload}  headers=${headers}    
    ${user_data}=    Set Variable    ${response.json()}
    Set Test Variable    ${contact_id}    ${user_data['_id']}
    [RETURN]    ${user_data['_id']}

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

    [Return]    ${payload}

Delete a contact if exists
    [Arguments]    ${contact_id}    ${token}
    [Documentation]    Delete a contact if it exists
    ${headers}=    Create Dictionary    Accept=application/json    Authorization=Bearer ${token}
    ${response}=    GET On Session    Session    /contacts/${contact_id}    headers=${headers}    expected_status=ANY
    Run Keyword If    '${response.status_code}' == '200'    DELETE On Session    Session    /contacts/${contact_id}    headers=${headers}
   


*** Test Cases ***


Verify structure of the new contact response structure
    [Documentation]    Verify structure of the new contact response structure
    # ${token}=    Login To The System    ${email}    ${password}
    ${headers}=    Create Dictionary    Accept=application/json    Authorization=Bearer ${token}
    ${payload}=    Generate Random Contact Payload
    Log To Console    ${payload}
    ${response}=    POST On Session  Session   /contacts   json=${payload}  headers=${headers}
    Should Be Equal As Numbers    ${response.status_code}    201
    ${response_data}=    Set Variable    ${response.json()}
    Set Test Variable    ${contact_id}    ${response_data['_id']}
    ${expected_fields}=    Create List    _id    firstName    lastName    birthdate    email    phone
    ...    street1    street2    city    stateProvince    postalCode    country    owner    __v
    FOR    ${field}    IN    @{expected_fields}
        Dictionary Should Contain Key    ${response_data}    ${field}
    END


Verify creating a new contact with valid data
    [Documentation]    Verify creating a new contact with valid data
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


Create a new contact with random data from data faker 
    [Documentation]    Create a new contact with random data from data faker
    ${headers}=    Create Dictionary    Accept=application/json    Authorization=Bearer ${token}
    ${firstName}=    faker.First Name
    ${lastName}=     faker.Last Name
    ${email}=        faker.Email
    ${birthdate}=    faker.Date Of Birth
    ${birthdate}=    Convert To String    ${birthdate}
    ${phone}=        Generate Random String    length=10    chars=[NUMBERS]
    ${street1}=      faker.Street Address
    ${street2}=      faker.Secondary Address
    ${city}=         faker.City
    ${stateProvince}=    faker.State
    ${postalCode}=   faker.Postal Code
    ${country}=      faker.Country
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
    Log To Console    ${payload}
    ${response}=    POST On Session  Session   /contacts   json=${payload}  headers=${headers}
    Should Be Equal As Numbers    ${response.status_code}    201
    ${user_data}=    Set Variable    ${response.json()}
    # Validate response fields
    FOR    ${field}    IN    firstName    lastName    email    phone    street1    street2    city    stateProvince    postalCode    country    birthdate
        Should Be Equal    ${user_data['${field}']}    ${payload}[${field}]    ignore_case=${field}=='email'
    END 


Create a new contact with random payload
    [Documentation]    Create a new contact with random data from data faker
    ${headers}=    Create Dictionary    Accept=application/json    Authorization=Bearer ${token}
    
    ${payload}=    Generate Random Contact Payload
    Log To Console    ${payload}

    ${response}=    POST On Session  Session   /contacts   json=${payload}  headers=${headers}
    Should Be Equal As Numbers    ${response.status_code}    201
    ${user_data}=    Set Variable    ${response.json()}

    ${fields}=    Create List    firstName    lastName    email    phone    street1    street2    city    stateProvince    postalCode    country    birthdate

    # Validate response fields
    FOR    ${field}    IN    @{fields}
        Should Be Equal    ${user_data['${field}']}    ${payload}[${field}]    ignore_case=${field}=='email'
    END 

Create a new contact after logout
    [Documentation]    Create a new contact after logout
    [Teardown]    No Operation
    ${headers}=    Create Dictionary    Accept=application/json    Authorization=Bearer ${token}
    ${payload}=    Generate Random Contact Payload
    Log To Console    ${payload}
    Logout user   ${token}
    ${response}=    POST On Session  Session   /contacts   json=${payload}  headers=${headers}   expected_status=401
    Should Be Equal As Numbers    ${response.status_code}    401
    Should Be Equal As Strings    ${response.reason}   Unauthorized


Create a new contact with random 
    [Documentation]    Create a new contact with random
    ${random_number}=    Evaluate    random.randint(10000, 10000000)    modules=random
    ${firstName_new_contact}=    Set Variable    Janesh${random_number}
    ${lastName_new_contact}=    Set Variable    Kodikara${random_number}
    ${id}=    Create a new contact    ${firstName_new_contact}    ${lastName_new_contact}    ${email}    ${token}
    ${headers}=    Create Dictionary    Accept=application/json    Authorization=Bearer ${token}
    ${response}=    GET On Session  Session   /contacts/${id}   headers=${headers}
    Should Be Equal As Numbers    ${response.status_code}    200
    Log To Console    message: ${response.json()}
    ${user_data}=    Set Variable    ${response.json()}
    Should Be Equal As Strings    ${user_data['firstName']}   ${firstName_new_contact}
    Should Be Equal As Strings    ${user_data['lastName']}   ${lastName_new_contact}



Update contact details 
    [Documentation]    Update contact details
    ${random_number}=    Evaluate    random.randint(10000, 10000000)    modules=random
    ${firstName_new_contact}=    Set Variable    Janesh${random_number}
    ${lastName_new_contact}=    Set Variable    Kodikara${random_number}
    ${headers}=    Create Dictionary    Accept=application/json    Authorization=Bearer ${token}
    ${id}=    Create a new contact    ${firstName_new_contact}    ${lastName_new_contact}   ${email}   ${token}
    ${payload}=    Create Dictionary    
     ...   firstName=${firstName_new_contact}  
     ...   lastName=${lastName_new_contact}    
     ...   email=${email} 
     ...   phone=0712345678
     ...   street1=123 Main St
     ...   street2=Suite 100
     ...   city=Colombo
     ...   stateProvince=Western
     ...   postalCode=12345
     ...   country=Sri Lanka
     ...   birthdate=1990-01-01
    ${response}=    PUT On Session  Session   /contacts/${id}   json=${payload}  headers=${headers}
    Should Be Equal As Numbers    ${response.status_code}    200
    ${user_data}=    Set Variable    ${response.json()}
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


Partial update of a contact details 
    ${random_number}=    Evaluate    random.randint(10000, 10000000)    modules=random
    ${firstName_new_contact}=    Set Variable    Janesh${random_number}
    ${lastName_new_contact}=    Set Variable    Kodikara${random_number}
    ${headers}=    Create Dictionary    Accept=application/json    Authorization=Bearer ${token}
    ${id}=    Create a new contact    ${firstName_new_contact}    ${lastName_new_contact}   ${email}   ${token}
    ${payload}=    Create Dictionary    
     ...   firstName=${firstName_new_contact}  
     ...   lastName=${lastName_new_contact}   
    ${response}=    PATCH On Session  Session   /contacts/${id}   json=${payload}  headers=${headers}
    Should Be Equal As Numbers    ${response.status_code}    200
    ${response_data}=    Set Variable    ${response.json()}
    Should Be Equal    ${response_data['firstName']}    ${payload}[firstName]   
    Should Be Equal    ${response_data['lastName']}    ${payload}[lastName]
    Should Be Equal    ${response_data['email']}    ${email}    ignore_case=True

    Log To Console     ${response_data}
    # Validate response fields
    ${expected_fields}=    Create List    _id    firstName    lastName    birthdate    email    phone
    ...    street1    street2    city    stateProvince    postalCode    country    owner    __v
    FOR    ${field}    IN    @{expected_fields}
        Dictionary Should Contain Key    ${response_data}    ${field}
    END



Get contact detais 
    [Documentation]    Get contact details

    ${headers}=    Create Dictionary    Accept=application/json    Authorization=Bearer ${token}
    ${payload}=    Generate Random Contact Payload

    #Create a new contact
    ${response}=    POST On Session  Session   /contacts   json=${payload}  headers=${headers}
    ${user_data}=    Set Variable    ${response.json()}
   
    #Get contact details
    ${response}=    GET On Session  Session   /contacts/${user_data['_id']}   headers=${headers}
    Should Be Equal As Numbers    ${response.status_code}    200
    ${user_data}=    Set Variable    ${response.json()}

    # Validate response fields
    ${fields}=    Create List    firstName    lastName    email    phone    street1    street2    city    stateProvince    postalCode    country    birthdate
    FOR    ${field}    IN    @{fields}
        Should Be Equal    ${user_data['${field}']}    ${payload}[${field}]    ignore_case=${field}=='email'
    END 


Delete a contact
    [Documentation]    Delete a contact
    ${random_number}=    Evaluate    random.randint(10000, 10000000)    modules=random
    ${firstName_new_contact}=    Set Variable    Janesh${random_number}
    ${lastName_new_contact}=    Set Variable    Kodikara${random_number}
    ${headers}=    Create Dictionary    Accept=application/json    Authorization=Bearer ${token}
    ${id}=    Create a new contact    ${firstName_new_contact}    ${lastName_new_contact}    ${email}    ${token}
    ${response}=    DELETE On Session  Session   /contacts/${id}   headers=${headers}
    Should Be Equal As Numbers    ${response.status_code}    200
    Should Be Equal As Strings    ${response.reason}    OK
    ${response}=    GET On Session  Session   /contacts/${id}   headers=${headers}    expected_status=ANY
    Should Be Equal As Numbers    ${response.status_code}    404
    Should Be Equal As Strings    ${response.reason}    Not Found