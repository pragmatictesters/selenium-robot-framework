*** Settings ***
Library           RequestsLibrary
Library           Collections
Library           String
Library           FakerLibrary    WITH NAME    faker
Library           ../../libraries/ContactLibrary.py
Library           ../../libraries/disable_warnings.py

Variables         ../../resources/variables/variables_api.py
Resource          ../../resources/keywords/api_keywords.robot

Suite Setup       disable_warnings
Test Setup        Login To The System    ${email}    ${password}
Test Teardown     Run Keywords
...               Delete a contact if exists    ${contact_id}    ${token}
...               AND
...               Logout user                ${token}


*** Test Cases ***


Verify structure of the new contact response structure
    [Documentation]    Verify structure of the new contact response structure
    ${headers}=    Create Dictionary    Accept=application/json    Authorization=Bearer ${token}
    ${payload}=    Generate Random Contact Payload
    # Log To Console    ${payload}
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
    ${payload}=    Generate Random Contact Payload
    ${response}=    POST On Session  Session   /contacts   json=${payload}  headers=${headers}
    Validate Response Status    ${response}    201
    ${user_data}=    Set Variable    ${response.json()}
    # Log To Console    ${response.json()}
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
    ${payload}=    Generate Random Contact Payload
    # Log To Console    ${payload}
    ${response}=    POST On Session  Session   /contacts   json=${payload}  headers=${headers}
    Validate Response Status    ${response}    201
    ${user_data}=    Set Variable    ${response.json()}
    # Validate response fields
    FOR    ${field}    IN    firstName    lastName    email    phone    street1    street2    city    stateProvince    postalCode    country    birthdate
        Should Be Equal    ${user_data['${field}']}    ${payload}[${field}]    ignore_case=${field}=='email'
    END 


Create a new contact with random payload
    [Documentation]    Create a new contact with random data from data faker
    ${headers}=    Create Dictionary    Accept=application/json    Authorization=Bearer ${token}
    
    ${payload}=    Generate Random Contact Payload
    # Log To Console    ${payload}

    ${response}=    POST On Session  Session   /contacts   json=${payload}  headers=${headers}
    Validate Response Status    ${response}    201
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
    # Log To Console    ${payload}
    Logout user   ${token}
    ${response}=    POST On Session  Session   /contacts   json=${payload}  headers=${headers}   expected_status=401
    Validate Response Status    ${response}    401
    Validate Response message    ${response}    Unauthorized


Create a new contact with random 
    [Documentation]    Create a new contact with random
    ${random_number}=    Evaluate    random.randint(10000, 10000000)    modules=random
    ${firstName_new_contact}=    Set Variable    Janesh${random_number}
    ${lastName_new_contact}=    Set Variable    Kodikara${random_number}
    ${id}=    Create a new contact    ${firstName_new_contact}    ${lastName_new_contact}    ${email}    ${token}
    ${headers}=    Create Dictionary    Accept=application/json    Authorization=Bearer ${token}
    ${response}=    GET On Session  Session   /contacts/${id}   headers=${headers}
    Validate Response Status    ${response}    200
    # Log To Console    message: ${response.json()}
    ${user_data}=    Set Variable    ${response.json()}
    Should Be Equal As Strings    ${user_data['firstName']}   ${firstName_new_contact}
    Should Be Equal As Strings    ${user_data['lastName']}   ${lastName_new_contact}



Update contact details 
    [Documentation]    Update contact details
    ${headers}=    Create Dictionary    Accept=application/json    Authorization=Bearer ${token}
    ${id}=    Create a new contact with randon data
    ${payload}=    Generate Random Contact Payload
    ${response}=    PUT On Session  Session   /contacts/${id}   json=${payload}  headers=${headers}
    Validate Response Status    ${response}    200
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
   
    ${payload_initial}=    Generate Random Contact Payload
    ${response}=    POST On Session  Session   /contacts   json=${payload_initial}  headers=${headers}    
    ${user_data}=    Set Variable    ${response.json()}
    ${id}=    Set Variable    ${user_data['_id']}

    ${payload_new}=    Create Dictionary    
     ...   firstName=${firstName_new_contact}  
     ...   lastName=${lastName_new_contact}   
    ${response}=    PATCH On Session  Session   /contacts/${id}   json=${payload_new}  headers=${headers}
    Validate Response Status    ${response}    200
    ${response_data}=    Set Variable    ${response.json()}
    Should Be Equal    ${response_data['firstName']}    ${payload_new}[firstName]   
    Should Be Equal    ${response_data['lastName']}    ${payload_new}[lastName]
    Should Be Equal    ${response_data['email']}    ${payload_initial}[email]    ignore_case=True
    Should Be Equal    ${response_data['phone']}    ${payload_initial}[phone]
    Should Be Equal    ${response_data['street1']}    ${payload_initial}[street1]
    Should Be Equal    ${response_data['street2']}    ${payload_initial}[street2]
    Should Be Equal    ${response_data['city']}    ${payload_initial}[city]
    Should Be Equal    ${response_data['stateProvince']}    ${payload_initial}[stateProvince]
    Should Be Equal    ${response_data['postalCode']}    ${payload_initial}[postalCode]
    Should Be Equal    ${response_data['country']}    ${payload_initial}[country]
    Should Be Equal    ${response_data['birthdate']}    ${payload_initial}[birthdate]


    # Log To Console     ${response_data}
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
    Validate Response Status    ${response}    200
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
    Validate Response Status    ${response}    200
    Validate Response message    ${response}    OK
    ${response}=    GET On Session  Session   /contacts/${id}   headers=${headers}    expected_status=ANY
    Validate Response Status    ${response}    404
    Validate Response message    ${response}    Not Found