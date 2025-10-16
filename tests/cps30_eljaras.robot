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

# Várjuk, hogy a felugró ablak megjelenjen
    Wait Until Element Is Visible    xpath=//*[@id="screen_1"]/div[2]/div
    Sleep    10s

##### Adminisztráció blokk elemzése
    ${text}=    Get Text    xpath=//span[@title="Eljárás azonosító"]
    Érték szöveg és nem üres    ${text}
    ${text}=    Get Text    xpath=//span[@title="Fő CPV kód"]
    Érték szöveg és nem üres    ${text}
    ${text}=    Get Text    xpath=//span[@title="Szervező"]
    Érték szöveg és nem üres    ${text}
    ${text}=    Get Text    xpath=//span[@title="Vállalat"]
    Érték szöveg és nem üres    ${text}
    ${text}=    Get Text    xpath=//span[@title="Szervezeti egység"]
    Érték szöveg és nem üres    ${text}
    ${text}=    Get Text    xpath=//span[@title="Beszerzési szervezeti egység"]
    Érték szöveg és nem üres    ${text}
    ${text}=    Get Text    xpath=//span[@title="Ajánlatkérői minőség"]
    Érték szöveg és nem üres    ${text}
    ${text}=    Get Text    xpath=//span[@title="Benyújtott ajánlatok száma"]
    Érték szöveg és nem üres    ${text}
    ${text}=    Get Text    xpath=//span[@title="Eredmény"]
    Érték szöveg és nem üres    ${text}
    ${text}=    Get Text    xpath=//span[@title="Megjegyzés"]
    Érték szöveg és nem üres    ${text}
    ${text}=    Get Text    xpath=//span[@title="Eljárás indítás időpontja"]
    Érték szöveg és nem üres    ${text}
    ${text}=    Get Text    xpath=//span[@title="Ajánlatok bontásának időpontja"]
    Érték szöveg és nem üres    ${text}
    ${text}=    Get Text    xpath=//span[@title="Ajánlatok elbírálásáról készített összegezés megküldésének időpontja"]
    Érték szöveg és nem üres    ${text}
    ${text}=    Get Text    xpath=//span[@title="Igény azonosító"]
    Érték szöveg és nem üres    ${text}
    ${text}=    Get Text    xpath=//span[@title="Igény típusa"]
    Érték szöveg és nem üres    ${text}
    ${text}=    Get Text    xpath=//span[@title="Tervsor azonosító"]
    Érték szöveg és nem üres    ${text}
    ${text}=    Get Text    xpath=//span[@title="Tervezett beszerzés"]
    Érték szöveg és nem üres    ${text}
    ${text}=    Get Text    xpath=//span[@title="Költségtípus"]
    Érték szöveg és nem üres    ${text}
    ${text}=    Get Text    xpath=//span[@title="Beszerzési kategória"]
    Érték szöveg és nem üres    ${text}


##### Részterületek
# Oszlopnevek validálása a táblázatban
    ${expected_columns}=    Create List    SORSZÁM    RÉSZTERÜLET
    Validate Table Columns    @{expected_columns}


##### Cikkek/szolgáltatások táblázat validálása
# 1) Kattintás a "Részterületek" melletti három pontra
    Click Element    xpath=//a[contains(text(),"Részterületek")]/following::a[@class="tab_menu_dropdown_link"][1]
    Sleep    2s
    
# 2) Kattintás a legördülő menüben a "Cikkek/szolgáltatások" elemre (id alapján)
    Click Element    xpath=//a[@id="Screen_CPS_SourcingEvent@Screen_CPS_SourcingEventEdit/2//_tab_SourcingEventLine_Tab"]
    Sleep    1s

# Oszlopnevek validálása a táblázatban
    ${expected_columns}=    Create List    CIKK SZÁM    CIKK NÉV    MENNYISÉG    EGYSÉG    SZÁLLÍTÁSI DÁTUM    INFÓ A SZÁLLÍTÓNAK    MEGJEGYZÉSEK
    Validate Table Columns    @{expected_columns}

##### Résztvevők táblázat validálása
# 1) Kattintás a "Részterületek" melletti három pontra
    Click Element    xpath=//a[contains(text(),"Részterületek")]/following::a[@class="tab_menu_dropdown_link"][1]
    Sleep    1s

# 2) Kattintás a legördülő menüben a "Résztvevők" elemre (id alapján)
    Click Element    xpath=//a[@id="Screen_CPS_SourcingEvent@Screen_CPS_SourcingEventEdit/2//_tab_Participants_Tab"]
    Sleep    1s    

# Oszlopnevek validálása a táblázatban
    ${expected_columns}=    Create List    FELHASZNÁLÓ    SZEREPKÖR    SZAKÉRTELEM    BB ELNÖK
    Validate Table Columns    @{expected_columns}   

##### Feltételek táblázat validálása
# 1) Kattintás a "Részterületek" melletti három pontra
    Click Element    xpath=//a[contains(text(),"Részterületek")]/following::a[@class="tab_menu_dropdown_link"][1]
    Sleep    1s

# 2) Kattintás a legördülő menüben a "Feltételek" elemre (id alapján)
    Click Element    xpath=//a[@id="Screen_CPS_SourcingEvent@Screen_CPS_SourcingEventEdit/2//_tab_SourcingEventTerm_Tab"]
    Sleep    1s    

# Oszlopnevek validálása a táblázatban
    ${expected_columns}=    Create List    FELTÉTEL TÍPUSA    SORSZÁM    KÉRDÉS    KÉRDÉS TÍPUSA    DOKUMENTUM TÍPUSA
    Validate Table Columns    @{expected_columns}  


##### Beadási dátumok táblázat validálása
# 1) Kattintás a "Részterületek" melletti három pontra
    Click Element    xpath=//a[contains(text(),"Részterületek")]/following::a[@class="tab_menu_dropdown_link"][1]
    Sleep    1s

# 2) Kattintás a legördülő menüben a "Beadási dátumok" elemre (id alapján)
    Click Element    xpath=//a[@id="Screen_CPS_SourcingEvent@Screen_CPS_SourcingEventEdit/2//_tab_BidSubmissionDate_Tab"]
    Sleep    1s    

# Oszlopnevek validálása a táblázatban
    ${expected_columns}=    Create List    SORSZÁM    ELJÁRÁS SZAKASZ    AJÁNLATADÁS TÍPUSA    BEADÁSI IDŐPONT KEZDETE    BEADÁSI IDŐPONT VÉGE
    Validate Table Columns    @{expected_columns}  


##### Jóváhagyók
# 1) Kattintás a "Részterületek" melletti három pontra
    Click Element    xpath=//a[contains(text(),"Részterületek")]/following::a[@class="tab_menu_dropdown_link"][1]
    Sleep    1s

# 2) Kattintás a legördülő menüben a "Jóváhagyók" elemre (id alapján)
    Click Element    xpath=//a[@id="Screen_CPS_SourcingEvent@Screen_CPS_SourcingEventEdit/2//_tab_Approver_Tab"]
    Sleep    1s    

# Oszlopnevek validálása a táblázatban
    ${expected_columns}=    Create List    JÓVÁHAGYÓ    FELADAT NEVE    JÓVÁHAGYÓ SZEREPKÖRE    EREDMÉNY    FELADAT ELVÉGZÉSE
    Validate Table Columns    @{expected_columns}  


##### Dokumentumok
# 1) Kattintás a "Részterületek" melletti három pontra
    Click Element    xpath=//a[contains(text(),"Részterületek")]/following::a[@class="tab_menu_dropdown_link"][1]
    Sleep    1s

# 2) Kattintás a legördülő menüben a "Dokumentumok" elemre (id alapján)
    Click Element    xpath=//a[@id="Screen_CPS_SourcingEvent@Screen_CPS_SourcingEventEdit/2//_tab_Documents_Tab"]
    Sleep    1s    

# Oszlopnevek validálása a táblázatban
    ${expected_columns}=    Create List    LETÖLTÉS    ELŐNÉZET    DOKUMENTUM    VERZIÓ    DOKUMENTUM TÍPUS    FELTÖLTÉS DÁTUMA    FELTÖLTŐ
    Validate Table Columns    @{expected_columns}


##### Kommunikáció
# 1) Kattintás a "Részterületek" melletti három pontra
    Click Element    xpath=//a[contains(text(),"Részterületek")]/following::a[@class="tab_menu_dropdown_link"][1]
    Sleep    1s

# 2) Kattintás a legördülő menüben a "Kommunikáció" elemre (id alapján)
    Click Element    xpath=//a[@id="Screen_CPS_SourcingEvent@Screen_CPS_SourcingEventEdit/2//_tab_Communications_Tab"]
    Sleep    1s    

# Oszlopnevek validálása a táblázatban
    ${expected_columns}=    Create List    TÁRGY    CÍMZETT    KIKÜLDÉS DÁTUMA    STÁTUSZ
    Validate Table Columns    @{expected_columns}  


##### Ellenőrzés adatok
# 1) Kattintás a "Részterületek" melletti három pontra
    Click Element    xpath=//a[contains(text(),"Részterületek")]/following::a[@class="tab_menu_dropdown_link"][1]
    Sleep    1s

# 2) Kattintás a legördülő menüben a "Ellenőrzés adatok" elemre (id alapján)
    Click Element    xpath=//a[@id="Screen_CPS_SourcingEvent@Screen_CPS_SourcingEventEdit/2//_tab_Audit_Tab"]
    Sleep    1s    

# Oszlopnevek validálása a táblázatban
    ${expected_columns}=    Create List    ELLENŐRZŐ SZERV    ELLENŐRZÉS FORMÁJA    ELLENŐRZÉSRE KÜLDÖTT IRATOK
    Validate Table Columns    @{expected_columns}


##### Hirdetmény adatok
# 1) Kattintás a "Részterületek" melletti három pontra
    Click Element    xpath=//a[contains(text(),"Részterületek")]/following::a[@class="tab_menu_dropdown_link"][1]
    Sleep    1s

# 2) Kattintás a legördülő menüben a "Hirdetmény adatok" elemre (id alapján)
    Click Element    xpath=//a[@id="Screen_CPS_SourcingEvent@Screen_CPS_SourcingEventEdit/2//_tab_Announcement_Tab"]
    Sleep    1s    

# Oszlopnevek validálása a táblázatban
    ${expected_columns}=    Create List    HIRDETMÉNY TÍPUSA    HIRDETMÉNY SZÁMA    HIRDETMÉNY FELADÁSÁNAK DÁTUMA    HIÁNYPÓTLÁS TÖRTÉNT    MEGJELENÉS DÁTUMA  
    Validate Table Columns    @{expected_columns}


##### Feladatok táblázat validálása
# 1) Kattintás a "Részterületek" melletti három pontra
    Click Element    xpath=//a[contains(text(),"Részterületek")]/following::a[@class="tab_menu_dropdown_link"][1]
    Sleep    1s
    
# 2) Kattintás a legördülő menüben a "Feladatok" elemre (id alapján)
    Click Element    xpath=//a[@id="Screen_CPS_SourcingEvent@Screen_CPS_SourcingEventEdit/2//_tab_Tasks_Tab"]
    Sleep    1s

# 3) Kattintás az első elemre a feladatok közül, ott pedig a linkre
    Click Element    xpath=(//a[contains(@class,"card-owf-task-title")])[1]
    Sleep    1s

    ${text}=    Get Text    xpath=//table[@class="OPM_GeneralTable_Table"]//tr[td[text()="Eljárás azonosító"]]/td[@class="OPM_GeneralTable_ValueColumn"]
    Érték szöveg és nem üres    ${text}

    ${text}=    Get Text    xpath=//table[@class="OPM_GeneralTable_Table"]//tr[td[text()="Vállalat"]]/td[@class="OPM_GeneralTable_ValueColumn"]
    Érték szöveg és nem üres    ${text}
    Sleep    2s

# Leírás mező validálása
    ${text}=    Get Value    xpath=//span[text()="Leírás"]/ancestor::div[contains(@class,"col-sm-3")]/following-sibling::div[contains(@class,"col-sm-9")]//textarea[contains(@id,"TextBox_DescriptionMultilang_multi")]
    Should Not Be Empty    ${text}    Az érték üres!

# Entitás típusa mező validálása
    ${text}=    Get Value    xpath=//span[text()="Entitás típus"]/ancestor::div[contains(@class,"col-sm-3")]/following-sibling::div[contains(@class,"col-sm-9")]//input[contains(@id,"ComboBox_EntityMetadataID_placeholder")]
    Should Not Be Empty    ${text}    Az Entitás típusa értéke üres!  

# Létrehozás dátuma mező validálása
    ${date}=    Get Value    xpath=//span[text()="Létrehozva"]/ancestor::div[contains(@class,"col-sm-3")]/following-sibling::div[contains(@class,"col-sm-9")]//input[contains(@id,"DateTime_Created")]
    Should Match Regexp    ${date}    ^\\d{4}\\.\\d{2}\\.\\d{2}\\. \\d{2}:\\d{2}$    A Létrehozás dátuma nem megfelelő formátumú!

# Feladat határideje validálása
    ${deadline}=    Get Value    xpath=//span[text()="Határidő"]/ancestor::div[contains(@class,"col-sm-3")]/following-sibling::div[contains(@class,"col-sm-9")]//input[contains(@id,"DateTime_Deadline")]
    Run Keyword If    '${deadline}' == ''    Log    Határidő nincs kitöltve!
    ...    ELSE    Should Match Regexp    ${deadline}    ^\\d{4}\\.\\d{2}\\.\\d{2}\\. \\d{2}:\\d{2}$    A Határidő nem megfelelő formátumú!    

# Kilépés a feladat részletekből az ESCAPE gombbal
    Press Keys    xpath=//body    ESCAPE
    Sleep    1s


##### Eljárás eredménye ablak
#Eljárás eredménye gomb megnyomása
    Wait Until Element Is Visible    xpath=//button[@id="Screen_CPS_SourcingEvent@Screen_CPS_SourcingEventEdit/3/SourcingEventBid_Tab/SourcingEventResult"]    4s
    Click Element    xpath=//button[@id="Screen_CPS_SourcingEvent@Screen_CPS_SourcingEventEdit/3/SourcingEventBid_Tab/SourcingEventResult"]
    Sleep    1s

    ${expected_columns}=    Create List    SORSZÁM    RÉSZTERÜLET  
    Validate Table Columns    @{expected_columns}


##### Ajánlatok tab alatt lévő ag-Grid táblázat fejlécének pontos kigyűjtése (header row div alapján)
# Várjuk, hogy a felugró ablak megjelenjen
    Wait Until Element Is Visible    xpath=//*[@id="screen_1"]/div[2]/div

    ${header_cells}=    Run Keyword And Continue On Failure    Get WebElements    xpath=//*[@id="center"]/div/div[1]/div[3]/div/div/div[contains(@class,"ag-header-cell")]
    ${actual_columns}=    Run Keyword And Continue On Failure    Create List
    FOR    ${cell}    IN    @{header_cells}
        ${text}=    Run Keyword And Continue On Failure    Get Text    ${cell}
        ${text}=    Strip String    ${text}
        IF    '${text}' == ''
            ${text}=    Run Keyword And Continue On Failure    Get Element Attribute    ${cell}    title
            ${text}=    Strip String    ${text}
        END
        ${text}=    Convert To Lowercase    ${text}
        Run Keyword And Continue On Failure    Log    Fejléc cella szöveg: ${text}
        IF    '${text}' != ''
            ${actual_columns}=    Run Keyword And Continue On Failure    Set Variable    ${actual_columns} + [${text}]
        END
    END
    Run Keyword And Continue On Failure    Log    Talált oszlopok: ${actual_columns}

    # Elvárt oszlopnevek
    ${elvart_oszlopok}=    Create List    Gazdasági szereplő azonosító    Gazdasági szereplő neve    Kontakt    Státusz    Portál felhasználó    Ajánlat nettó összege    Ajánlat bruttó összege    Pénznem    Benyújtás dátuma    Típus    Eljárás szakasz sorszáma    Eljárás szakasz    Keretmegállapodás azonosító
    Log    Elvárt oszlopok: ${elvart_oszlopok}

    FOR    ${col}    IN    @{elvart_oszlopok}
        ${col}=    Strip String    ${col}
        ${col}=    Convert To Lowercase    ${col}
        Run Keyword And Continue On Failure    Should Contain    ${actual_columns}    ${col}
    END

# Kilépés az Eljárás Eredménye ablakból az ESCAPE gombbal
    Press Keys    xpath=//body    ESCAPE
    Sleep    1s

##### Ajánlat áttekintése gomb megnyomása (pontos id alapján)
    Wait Until Element Is Visible    xpath=//button[@id="Screen_CPS_SourcingEvent@Screen_CPS_SourcingEventEdit/3/SourcingEventBid_Tab/ButtonDropDown_BidOverview"]    2s
    Scroll Element Into View    xpath=//button[@id="Screen_CPS_SourcingEvent@Screen_CPS_SourcingEventEdit/3/SourcingEventBid_Tab/ButtonDropDown_BidOverview"]
    Click Element    xpath=//button[@id="Screen_CPS_SourcingEvent@Screen_CPS_SourcingEventEdit/3/SourcingEventBid_Tab/ButtonDropDown_BidOverview"]
    Wait Until Element Is Visible    xpath=//div[@id="Screen_CPS_SourcingEvent@Screen_CPS_SourcingEventEdit/3/SourcingEventBid_Tab/ButtonDropDown_BidOverview_dropdown"]    5s
    Click Element    xpath=//div[@id="Screen_CPS_SourcingEvent@Screen_CPS_SourcingEventEdit/3/SourcingEventBid_Tab/ButtonDropDown_BidOverview_item_BidLines"]
    Sleep    1s

# Ajánlat sorok áttekintése táblázat
    ${expected_columns}=    Create List    CIKK NÉV    MENNYISÉG    EGYSÉG    SZÁLLÍTÁSI DÁTUM    INFÓ A SZÁLLÍTÓNAK    MEGJEGYZÉSEK  
    Validate Table Columns    @{expected_columns}
    Sleep    1s

    Click Element    xpath=(//div[@id="Screen_CPS_SourcingEvent@Screen_CPS_SourcingEventEdit@Screen_CPS_SourcingEventBidLineOverView/1//_activeTab"]//div[contains(@class,"ag-body-container")]/div[contains(@class,"ag-row-level-1")][1]//div[@colid="ItemName"])
    Sleep    1s

# Licit elemek összesítése táblázat fejlécének kigyűjtése és validálása
    ${header_cells}=    Get WebElements    xpath=//div[@id="Screen_CPS_SourcingEvent@Screen_CPS_SourcingEventEdit@Screen_CPS_SourcingEventBidLineOverView/2//_activeTab"]//div[contains(@class,"ag-header-cell")]
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
        # Csak akkor adjuk hozzá, ha nem üres és még nincs a listában (megelőzi a duplikációt)
        IF    $text != '' and $text not in $actual_columns
             ${actual_columns}=    Run Keyword And Continue On Failure    Set Variable    ${actual_columns} + [${text}]
         END
    END
    Run Keyword And Continue On Failure    Log    Talált oszlopok: ${actual_columns}

# Elvárt oszlopnevek kisbetűsítve
    ${elvart_oszlopok}=    Create List    szállító azonosító    szállító neve    részterület    eljárás szakasz sorszáma    eljárás szakasz    benyújtás dátuma    cikkszám    cikk neve    mennyiség    mértékegység    egységár    kedvezmény    nettó összeg    áfa (%)    bruttó összeg    szállító cikk részletek
    Log    Elvárt oszlopok: ${elvart_oszlopok}

    FOR    ${col}    IN    @{elvart_oszlopok}
        ${col}=    Strip String    ${col}
        ${col}=    Convert To Lowercase    ${col}
        Run Keyword And Continue On Failure    Should Contain    ${actual_columns}    ${col}
    END


# Kilépés az Ajánlat sorok áttekintése ablakból az ESCAPE gombbal
    Press Keys    xpath=//body    ESCAPE
    Sleep    1s


##### Ajánlat áttekintése gomb megnyomása (pontos id alapján)
    Wait Until Element Is Visible    xpath=//button[@id="Screen_CPS_SourcingEvent@Screen_CPS_SourcingEventEdit/3/SourcingEventBid_Tab/ButtonDropDown_BidOverview"]    2s
    Click Element    xpath=//button[@id="Screen_CPS_SourcingEvent@Screen_CPS_SourcingEventEdit/3/SourcingEventBid_Tab/ButtonDropDown_BidOverview"]
    Wait Until Element Is Visible    xpath=//div[@id="Screen_CPS_SourcingEvent@Screen_CPS_SourcingEventEdit/3/SourcingEventBid_Tab/ButtonDropDown_BidOverview_item_TermLines"]    5s
    Click Element    xpath=//div[@id="Screen_CPS_SourcingEvent@Screen_CPS_SourcingEventEdit/3/SourcingEventBid_Tab/ButtonDropDown_BidOverview_item_TermLines"]
    Sleep    1s

# Ajánlat feltételek áttekintése táblázat
    ${expected_columns}=    Create List    FELTÉTEL TÍPUSA    KÉRDÉS  
    Validate Table Columns    @{expected_columns}
    Sleep    1s  

# Ajánlati fetételek táblázat ban az első sor kiválasztása
    Click Element    xpath=(//div[@id="Screen_CPS_SourcingEvent@Screen_CPS_SourcingEventEdit@Screen_CPS_SourcingEventTermOverView/1//_activeTab"]//div[contains(@class,"ag-body-container")]/div[contains(@class,"ag-row")])[2]
    Sleep    2s 
         
# Kilépés az Ajánlati feltételek áttekintése ablakból az ESCAPE gombbal
    Press Keys    xpath=//body    ESCAPE
    Sleep    1s


##### Eljárás eredménye gomb megnyomása
    Wait Until Element Is Visible    xpath=//button[@id="Screen_CPS_SourcingEvent@Screen_CPS_SourcingEventEdit/3/SourcingEventBid_Tab/SourcingEventResult"]    2s
    Click Element    xpath=//button[@id="Screen_CPS_SourcingEvent@Screen_CPS_SourcingEventEdit/3/SourcingEventBid_Tab/SourcingEventResult"]
    Sleep    1s

# Eljárás eredménye, Részterületek táblázat
    ${expected_columns}=    Create List    SORSZÁM    RÉSZTERÜLET  
    Validate Table Columns    @{expected_columns}  
    Sleep    1s  

    Click Element    xpath=(//div[@id="Screen_CPS_SourcingEvent@Screen_CPS_SourcingEventEdit@Screen_CPS_SourcingEventResult/1//_activeTab"]//div[contains(@class,"ag-body-container")]/div[contains(@class,"ag-row")])[1]
    Sleep    1s 

# Eredmény adatok táblázat
    ${expected_columns}=    Create List    ELJÁRÁS SZAKASZ    ELJÁRÁS SZAKASZ SORSZÁMA    GAZDASÁGI SZEREPLŐ NEVE    BENYÚJTÁS DÁTUMA    VÉGLEGES AJÁNLAT?    ÉRVÉNYES AJÁNLATOT TETT?    NYERTES?    ELLENSZOLGÁLTATÁS ÖSSZEGE (NETTÓ)
    Validate Table Columns    @{expected_columns}
    Sleep    2s

