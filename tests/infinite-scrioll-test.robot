*** Settings ***
Library       SeleniumLibrary
Test Setup    Open Browser In Incognito Mode    ${URL}
Test Teardown    Close Browser


*** Variables ***
${URL}      https://the-internet.herokuapp.com


*** Keywords ***
Open Browser In Incognito Mode
    [Documentation]    Open Chrome in incognito mode
    [Arguments]    ${url}
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${options}    add_argument    --incognito
    Create WebDriver    Chrome    options=${options}
    Maximize Browser Window

*** Test Cases ***

Test context menu 
    [Documentation]    Launch Chrome in incognito and Scroll to the bottom of the page
    Go To    ${URL}/infinite_scroll
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
    Sleep    2s    # give time to load new content if needed

    ${height}=    Execute JavaScript    return window.innerHeight
    Log    Viewport height: ${height}

    ${scroll_height}=    Execute JavaScript    return document.documentElement.scrollHeight
    Log    Full scrollable height: ${scroll_height}

    ${scroll_top}=    Execute JavaScript    return window.pageYOffset
    Log    Scrolled offset from top: ${scroll_top}

    