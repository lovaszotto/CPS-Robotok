*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}    https://172.28.30.5/cps30/

*** Test Cases ***
Simple Login Test
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${options}    add_argument    --ignore-certificate-errors
    Open Browser    ${URL}    chrome    options=${options}
    Maximize Browser Window
    Sleep    5s
    
    # Ellenőrizzük, hogy megjelent-e a bejelentkezési oldal
    Wait Until Element Is Visible    id=username    60s
    
    # Bejelentkezés
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
    
    # Várjuk meg a bejelentkezés sikerességét
    Wait Until Element Is Visible    id=logo    60s
    Sleep    5s
    
    # Csak egy egyszerű ellenőrzés
    Page Should Contain Element    id=logo
    
    Close Browser