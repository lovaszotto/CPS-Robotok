*** Settings ***
Library    SeleniumLibrary
Library    String
Library    Collections
Resource    ../resources/oriana_login.resource
Resource    ../resources/table_keywords.resource

*** Keywords ***
Handle Modal Dialog
    # Modal ablak ellenőrzés és ESC megnyomása ha van
    ${modal_present}=    Run Keyword And Return Status    Element Should Be Visible    css=.bootbox.modal
    Run Keyword If    ${modal_present}    Press Keys    None    ESCAPE
    Run Keyword If    ${modal_present}    Sleep    1s
    Run Keyword If    ${modal_present}    Log    Modal ablak bezárva ESC-cel

Érték szöveg és nem üres
    [Arguments]    ${text}
    # Biztonságosabb ellenőrzés: csak ellenőrizzük, hogy nem üres és nem None
    Run Keyword If    $text == 'None' or $text == ''    Fail    Az érték nem szöveg vagy üres!
    Should Not Be Empty    ${text}    Az érték üres!

*** Test Cases ***
VBÜ Oriana ELJÁRÁS oldal megnyitása
    Bejelentkezés admin felhasználóval

# Modal ablak kezelése ha van
    Handle Modal Dialog

# Kattintás a három-pont menüre (ellipsis toggle)
    Wait Until Element Is Visible    id=menu_mm_ellipsisToggle    10s
    Click Element    id=menu_mm_ellipsisToggle
    Sleep    2s

# Kiválasztjuk az "Eljárás" menüpontot
    Wait Until Element Is Visible    id=menu_mm_MM_CPS_Sourcing    10s
    Click Element    id=menu_mm_MM_CPS_Sourcing
    Sleep    3s

# Várjuk, hogy az ag-Grid fő táblázat megjelenjen
    Wait Until Page Contains Element    xpath=//div[contains(@class,"ag-body-container")]/div[contains(@class,"ag-row")]    30s

# Modal ablak kezelése ha van
    Handle Modal Dialog

# Kattintás az első sor első oszlopában lévő linkre
    Wait Until Element Is Visible    xpath=(//div[contains(@class,"ag-body-container")]/div[contains(@class,"ag-row")])[1]//div[@colid="SourcingEventCode"]//a    10s
    Click Element    xpath=(//div[contains(@class,"ag-body-container")]/div[contains(@class,"ag-row")])[1]//div[@colid="SourcingEventCode"]//a

# Várjuk, hogy az Ajánlatok tab felugró ablak megjelenjen
    Wait Until Element Is Visible    xpath=//*[@id="screen_1"]/div[2]/div
    Sleep    5s


##### Ajánlatok tab
# Kattintsunk az első sor első mezőjére, linkre
    Wait Until Element Is Visible    xpath=(//div[contains(@class,"ag-body-container")]/div[contains(@class,"ag-row") and contains(@class,'ag-row-level-1')])[1]//div[@colid="PartnerCode"]//a    10s
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

    # Robosztus ellenőrzés: ellenőrizzük az input checked attribútumát és a vizuális <i> elem osztályát is
    ${cons_input_xpath}=    Set Variable    xpath=//*[@id="Screen_CPS_SourcingEvent@Screen_CPS_SourcingEventEdit@Screen_CPS_SourcingEventBidEdit/1/Component_OPM_SourcingEventBidEdit/CheckBox_Consortium"]
    ${cons_visual_xpath}=    Set Variable    xpath=//*[@id="Screen_CPS_SourcingEvent@Screen_CPS_SourcingEventEdit@Screen_CPS_SourcingEventBidEdit/1/Component_OPM_SourcingEventBidEdit/CheckBox_Consortium_i"]

    # 1) Ellenőrizzük az input checkboxot (ha létezik és valódi input)
    ${cons_checked}=    Run Keyword And Return Status    Checkbox Should Be Selected    ${cons_input_xpath}
    Run Keyword If    ${cons_checked}    Log To Console    Konzorcium checkbox (input) BE van pipálva.

    # 2) Ha az input nincs pipálva, nézzük meg a vizuális <i> elem osztályát, hátha csak a vizuális jelzés van bekapcsolva
    ${vis_status}    ${vis_cls}=    Run Keyword And Ignore Error    Get Element Attribute    ${cons_visual_xpath}    class
    Log To Console    Konzorcium vizuális elem attribútum lekérdezés: status='${vis_status}' class='${vis_cls}'
    ${visual_checked}=    Run Keyword And Return Status    Evaluate    'efi-check-box-checked2' in '${vis_cls}'
    Run Keyword If    ${visual_checked}    Log To Console    Konzorcium VIZUÁLISAN pipáltnak látszik (i.elem osztály alapján).

    # 3) Végső eldöntés: ha az input vagy a vizuális elem jelzi a pipát, treat as checked
    ${is_checked}=    Run Keyword And Return Status    Evaluate    ${cons_checked} or ${visual_checked}
    Run Keyword If    ${is_checked}    Log To Console    Konzorcium: végső állapot = pipálva
    Run Keyword If    not ${is_checked}    Log    'Konzorcium nincs pipálva sem inputon, sem vizuálisan.'    WARN

    # Ellenőrizzük, hogy megjelenik-e a "Konzorcium további résztvevői" felirat (ha pipáltnak tekintjük)
    Run Keyword If    ${is_checked}    Run Keyword And Continue On Failure    Page Should Contain Element    xpath=//label[contains(normalize-space(.),'Konzorcium további résztvevői')]

    # Mindig fusson egy ellenőrzés is, ami hibát jelez a futás közben, de nem állítja meg a tesztet
    Run Keyword And Continue On Failure    Page Should Contain Element    xpath=//label[contains(normalize-space(.),'Konzorcium további résztvevői')]

    ##### Ajánlat / Eljárás dátumok
    ${text}=    Get Text    xpath=//span[@title="Beadási időpont kezdete"]
    Érték szöveg és nem üres    ${text}
    ${text}=    Get Text    xpath=//span[@title="Benyújtási határidő"]
    Érték szöveg és nem üres    ${text}


##### Cikkek/szolgáltatások táblázat validálása
# Oszlopnevek validálása a táblázatban
    ${header_cells}=    Run Keyword And Continue On Failure    Get WebElements    xpath=//*[@id="center"]/div/div[1]/div[3]/div/div/div[contains(@class,"ag-header-cell")]
    ${actual_columns}=    Run Keyword And Continue On Failure    Create List
    FOR    ${cell}    IN    @{header_cells}
        ${text}=    Run Keyword And Continue On Failure    Get Text    ${cell}
        ${text}=    Strip String    ${text}
        IF    $text == ''
            ${text}=    Run Keyword And Continue On Failure    Get Element Attribute    ${cell}    title
            ${text}=    Strip String    ${text}
        END
        ${text}=    Convert To Lowercase    ${text}
        Run Keyword And Continue On Failure    Log    Fejléc cella szöveg: ${text}
        IF    $text != ''
            ${actual_columns}=    Run Keyword And Continue On Failure    Set Variable    ${actual_columns} + [${text}]
        END
    END
    Run Keyword And Continue On Failure    Log    Talált oszlopok: ${actual_columns}

    # Elvárt oszlopnevek
    ${elvart_oszlopok}=    Create List    RÉSZTERÜLET    CIKK SZÁM    CIKK NEVE    MENNYISÉG    EGYSÉG    SZÁLLÍTÓ INFÓ    SZÁLLÍTÓI CIKK SZÁM    SZÁLLÍTÓI CIKK NÉV    MEGJEGYZÉSEK    NETTÓ ÖSSZEG    ADÓ KÓD    ÁFA (%)    BRUTTÓ ÖSSZEG    ÁR
    Log    Elvárt oszlopok: ${elvart_oszlopok}

    FOR    ${col}    IN    @{elvart_oszlopok}
        ${col}=    Strip String    ${col}
        ${col}=    Convert To Lowercase    ${col}
        Run Keyword And Continue On Failure    Should Contain    ${actual_columns}    ${col}
    END     

##### Feltételek
    Wait Until Element Is Visible    xpath=//*[@id="Screen_CPS_SourcingEvent@Screen_CPS_SourcingEventEdit@Screen_CPS_SourcingEventBidEdit/2//_tab_SourcingEventTerm_Tab"]/div    10s
    Click Element    xpath=//*[@id="Screen_CPS_SourcingEvent@Screen_CPS_SourcingEventEdit@Screen_CPS_SourcingEventBidEdit/2//_tab_SourcingEventTerm_Tab"]/div    
    Sleep    1s

# Oszlopnevek validálása a táblázatban
    ${expected_columns}=    Create List    SORSZÁM    KÉRDÉS    VÁLASZ    MEGJEGYZÉS    MEGVÁLASZOLVA  
    Validate Table Columns    @{expected_columns}    
    Sleep    1s

##### Dokumentumok
    Wait Until Element Is Visible    xpath=//*[@id="Screen_CPS_SourcingEvent@Screen_CPS_SourcingEventEdit@Screen_CPS_SourcingEventBidEdit/2//_tab_Documents_Tab"]/div    10s
    Click Element    xpath=//*[@id="Screen_CPS_SourcingEvent@Screen_CPS_SourcingEventEdit@Screen_CPS_SourcingEventBidEdit/2//_tab_Documents_Tab"]/div    
    Sleep    1s

# Oszlopnevek validálása a táblázatban
    ${expected_columns}=    Create List    LETÖLTÉS    ELŐNÉZET    DOKUMENTUM    VERZIÓ    DOKUMENTUM TÍPUS    FELTÖLTÉS DÁTUMA    FELTÖLTŐ    KULCSSZAVAK  
    Validate Table Columns    @{expected_columns}    
    Sleep    1s    

##### Eredmény
    Wait Until Element Is Visible    xpath=//*[@id="Screen_CPS_SourcingEvent@Screen_CPS_SourcingEventEdit@Screen_CPS_SourcingEventBidEdit/2//_tab_SourcingEventBidResult_Tab"]/div    10s
    Click Element    xpath=//*[@id="Screen_CPS_SourcingEvent@Screen_CPS_SourcingEventEdit@Screen_CPS_SourcingEventBidEdit/2//_tab_SourcingEventBidResult_Tab"]/div    
    Sleep    1s

# Oszlopnevek validálása a táblázatban
    ${expected_columns}=    Create List    RÉSZTERÜLET    ELLENSZOLGÁLTATÁS ÖSSZEGE (NETTÓ FT)    ÉRVÉNYES AJÁNLATOT TETT?    NYERTES  
    Validate Table Columns    @{expected_columns}    
    Sleep    1s        