*** Settings ***
Library    SeleniumLibrary
Library    String
Library    Collections
Resource    ../resources/cps30_login.resource
Resource    ../resources/table_keywords.resource

*** Variables ***
${URL}    https://172.28.30.5/cps30/MM_CPS_Sourcing/Screen_CPS_SourcingEvent

*** Keywords ***
Érték szöveg és nem üres
    [Arguments]    ${text}
    Should Be True    '${text}' != ''    Az érték nem szöveg!
    Should Not Be Empty    ${text}    Az érték üres!

*** Test Cases ***

CPS30 ELJÁRÁS oldal megnyitása
    Bejelentkezés admin felhasználóval

# Várjuk, hogy az ag-Grid fő táblázat megjelenjen
    Wait Until Page Contains Element    xpath=//div[contains(@class,"ag-body-container")]/div[contains(@class,"ag-row")]    30s

# Kattintás az első sor első oszlopában lévő linkre
    Click Element    xpath=(//div[contains(@class,"ag-body-container")]/div[contains(@class,"ag-row")])[1]//div[@colid="SourcingEventCode"]//a

# Várjuk, hogy az Ajánlatok tab felugró ablak megjelenjen
    Wait Until Element Is Visible    xpath=//*[@id="screen_1"]/div[2]/div
    Sleep    5s


##### Ajánlatok tab
# Kattintsunk az első sor első mezőjére, linkre
    Click Element    xpath=(//div[contains(@class,"ag-body-container")]/div[contains(@class,"ag-row") and contains(@class,'ag-row-level-1')])[1]//div[@colid="PartnerCode"]//a
    Sleep    3s


    ##### Adminisztráció blokk elemzése
    ${text}=    Get Text    xpath=//span[@title="Beszerzési eljárás azonosító"]
    Érték szöveg és nem üres    ${text}
    ${text}=    Get Text    xpath=//span[@title="Beszerzési eljárás típusa"]
    Érték szöveg és nem üres    ${text}
    ${text}=    Get Text    xpath=//span[@title="Beszerzés tárgya"]
    Érték szöveg és nem üres    ${text}
    ${text}=    Get Text    xpath=//span[@title="Beszerzési eljárás státusza"]
    Érték szöveg és nem üres    ${text}
    ${text}=    Get Text    xpath=//span[@title="Ajánlattételi lehetőség az Ajánlattevői portálon?"]
    Érték szöveg és nem üres    ${text}
    ${text}=    Get Text    xpath=//span[@title="Szervező"]
    Érték szöveg és nem üres    ${text}
    ${text}=    Get Text    xpath=//span[@title="Pénznem"]
    Érték szöveg és nem üres    ${text}
    ${text}=    Get Text    xpath=//span[@title="Megjegyzések"]
    Érték szöveg és nem üres    ${text}

    ##### Ajánlat / részvételi jelentkezés adatok
    ${text}=    Get Text    xpath=//span[@title="Gazdasági szereplő azonosító"]
    Érték szöveg és nem üres    ${text}
    ${text}=    Get Text    xpath=//span[@title="Gazdasági szereplő neve"]
    Érték szöveg és nem üres    ${text}
    ${text}=    Get Text    xpath=//span[@title="Kapcsolattartó"]
    Érték szöveg és nem üres    ${text}
    ${text}=    Get Text    xpath=//span[@title="Portál felhasználó"]
    Érték szöveg és nem üres    ${text}
    ${text}=    Get Text    xpath=//span[@title="Konzorcium?"]
    Érték szöveg és nem üres    ${text}
    ${text}=    Get Text    xpath=//span[@title="Státusz"]
    Érték szöveg és nem üres    ${text}
    ${text}=    Get Text    xpath=//span[@title="Típus"]
    Érték szöveg és nem üres    ${text}
    ${text}=    Get Text    xpath=//span[@title="Eljárás szakasz neve"]
    Érték szöveg és nem üres    ${text}
    ${text}=    Get Text    xpath=//span[@title="Benyújtás dátuma"]
    Érték szöveg és nem üres    ${text}
    ${text}=    Get Text    xpath=//span[@title="Keretmegállapodás azonosító"]
    Érték szöveg és nem üres    ${text}

    ##### Ajánlat / Eljárás dátumok
    ${text}=    Get Text    xpath=//span[@title="Beadási időpont kezdete"]
    Érték szöveg és nem üres    ${text}
    ${text}=    Get Text    xpath=//span[@title="Benyújtási határidő"]
    Érték szöveg és nem üres    ${text}