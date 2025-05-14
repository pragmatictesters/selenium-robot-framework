*** Settings ***
Library    ../../venv/lib/python3.13/site-packages/robot/libraries/OperatingSystem.py

*** Variables ***
${NAME}=    Robot

*** Test Cases ***
Test Replace Variable
    [Documentation]    Test Replace Variable
    ${template} =	Get File	${CURDIR}/template.txt
    ${var}=    Replace Variables   ${template}
    Log To Console    ${var}
    Should Be Equal As Strings    ${var}    Hello Robot!