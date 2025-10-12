*** Keywords ***
Kérj Megerősítést Konzolban
    ${_}=    Evaluate    input('Kérlek, írj be bármit a folytatáshoz, majd nyomj Entert: ')
*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}    https://172.28.30.5/cps30/

*** Test Cases ***
Bejelentkezés admin felhasználóval
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${options}    add_argument    --ignore-certificate-errors
    Open Browser    ${URL}    chrome    options=${options}
    Maximize Browser Window
    Sleep    5s
    Wait Until Element Is Visible    id=username    60s
    Click Element    id=username
    Sleep    0.5s
    Input Text    id=username    admin
    Wait Until Element Is Visible    id=password    5s
    Click Element    id=password
    Sleep    0.5s
    Input Text    id=password    p
    Wait Until Element Is Visible    id=languages    30s
    Click Element    id=languages
    Wait Until Element Is Visible    css=.efi-angle-round-down    10s
    Sleep    2s
    Wait Until Element Is Visible    xpath=//*[contains(text(),'Magyar')]    20s
    Click Element    xpath=//*[contains(text(),'Magyar')]
    Click Element    id=languages
    Execute JavaScript    document.getElementById('login').click();
    Wait Until Element Is Visible    id=logo    60s
    Sleep    10s
    # Try to click the ELJÁRÁS menu item even if not visible
    Sleep    2s
    #Execute JavaScript    var el = Array.from(document.querySelectorAll('*')).find(e => e.textContent.trim() === 'ELJÁRÁS'); if (el) { el.dispatchEvent(new MouseEvent('mousedown', {bubbles:true})); el.dispatchEvent(new MouseEvent('mouseup', {bubbles:true})); el.dispatchEvent(new MouseEvent('click', {bubbles:true})); }
    Sleep    30s
    #Kérj Megerősítést Konzolban

