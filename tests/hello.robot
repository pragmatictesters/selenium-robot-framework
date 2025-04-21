*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}     https://www.google.com

*** Test Cases ***
Open Google
    Open Browser    https://www.google.com    chrome
    Input Text      name=q    Robot Framework
    Press Keys       name=q    ENTER
    Wait Until Page Contains Element    id=result-stats    10s