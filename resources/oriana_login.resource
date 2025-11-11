*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}    https://vbr.orianasoftware.com/VBR-CPS
${MS_EMAIL}    %{MS_EMAIL=zelina.attila@clarity.hu}
${MS_PASSWORD}    %{MS_PASSWORD=PokMalac236}

*** Keywords ***
Bejelentkezés admin felhasználóval
    ${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${chrome_options}    add_argument    --ignore-certificate-errors
    Call Method    ${chrome_options}    add_argument    --disable-web-security
    Call Method    ${chrome_options}    add_argument    --allow-running-insecure-content
    Open Browser    ${URL}    chrome    options=${chrome_options}
    Maximize Browser Window
    Sleep    5s
    
    # Várjuk meg, hogy betöltődjön az oldal - lehet Microsoft login vagy már bejelentkezve
    ${page_loaded}=    Run Keyword And Return Status    Wait Until Page Contains    Microsoft    5s
    Run Keyword If    ${page_loaded}    Log To Console    Microsoft bejelentkezési oldal betöltődött
    Run Keyword If    ${page_loaded}    Handle Microsoft Login
    Run Keyword If    not ${page_loaded}    Log To Console    Nem Microsoft login oldal
    
    # Ellenőrizzük, hogy bejelentkeztünk-e már
    ${already_logged}=    Run Keyword And Return Status    Wait Until Element Is Visible    id=logo    10s
    Run Keyword If    ${already_logged}    Log To Console    Már be vagyunk jelentkezve!
    Run Keyword If    ${already_logged}    Return From Keyword
    
    # Ha nincs logo, próbáljunk klasszikus CPS bejelentkezést
    ${username_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    id=username    5s
    Run Keyword If    ${username_visible}    Handle CPS Login
    
    # Végül várjuk meg a logo megjelenését
    Wait Until Element Is Visible    id=logo    10s
    Sleep    1s

Handle Microsoft Login
    Log To Console    Microsoft bejelentkezési folyamat...
    # Várjuk meg a Microsoft bejelentkezési oldal elemeit
    Wait Until Element Is Visible    xpath=//input[@type='email' or @type='text']    7s
    
    # Email cím beírása
    ${email_field}=    Get WebElement    xpath=//input[@type='email' or @type='text']
    Click Element    ${email_field}
    Sleep    1s
    Input Text    ${email_field}    ${MS_EMAIL}
    
    # Tovább gomb
    ${next_button}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath=//input[@type='submit' and @value='Tovább']    5s
    Run Keyword If    ${next_button}    Click Element    xpath=//input[@type='submit' and @value='Tovább']
    Run Keyword If    not ${next_button}    Click Element    xpath=//input[@type='submit']
    Sleep    1s
    
    # Jelszó beírása
    ${password_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath=//input[@type='password']    6s
    Run Keyword If    ${password_visible}    Input Text    xpath=//input[@type='password']    ${MS_PASSWORD}
    Run Keyword If    ${password_visible}    Click Element    xpath=//input[@type='submit']  
    Sleep    1s
    
    # "Bejelentkezve marad?" ablak kezelése
    ${stay_signed_in}=    Run Keyword And Return Status    Wait Until Page Contains    Bejelentkezve marad    5s
    Run Keyword If    ${stay_signed_in}    Log To Console    "Bejelentkezve marad?" ablak megjelent
    Run Keyword If    ${stay_signed_in}    Click Element    xpath=//input[@type='submit' and @value='Igen']
    
    # Várjuk meg, hogy átirányítson a CPS alkalmazásba
    Wait Until Element Is Visible    id=maintenance_messages    60s

Handle CPS Login
    Log To Console    CPS bejelentkezési folyamat...
    Click Element    id=username
    Sleep    0.5s
    Input Text    id=username    admin
    Wait Until Element Is Visible    id=password    5s
    Click Element    id=password
    Sleep    0.5s
    Input Text    id=password    p
    Sleep    1s
    Execute JavaScript    document.getElementById('login').click();
