*** Settings ***
Library    SeleniumLibrary
Library    String
Library    Collections
Resource    ../resources/oriana_login.resource
Resource    ../resources/table_keywords.resource

*** Keywords ***
Érték szöveg és nem üres
    [Arguments]    ${text}
    Should Be True    '${text}' != ''    Az érték nem szöveg!
    Should Not Be Empty    ${text}    Az érték üres!

*** Keywords ***
Handle Modal Dialog
    # Modal ablak ellenőrzés és ESC megnyomása ha van
    ${modal_present}=    Run Keyword And Return Status    Element Should Be Visible    css=.bootbox.modal
    Run Keyword If    ${modal_present}    Press Keys    None    ESCAPE
    Run Keyword If    ${modal_present}    Sleep    1s
    Run Keyword If    ${modal_present}    Log    Modal ablak bezárva ESC-cel  

*** Keywords ***
Kattintás táblázat sorra
    [Arguments]    ${sor_index}
    Wait Until Element Is Visible    xpath=(//div[contains(@class,"ag-body-container")]/div[contains(@class,"ag-row")])[${sor_index}]    5s
    Execute JavaScript    document.evaluate('(//div[contains(@class,"ag-body-container")]/div[contains(@class,"ag-row")])[${sor_index}]', document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.click();
    Log To Console    ✅ Kattintás a(z) ${sor_index}. sorra sikeres.
    Sleep    2s    

*** Keywords ***
Kattintás sor linkre
    [Arguments]    ${sor_index}
    ${xpath}=    Set Variable    (//div[contains(@class,"ag-body-container")]/div[contains(@class,"ag-row")])[${sor_index}]//div[@colid="SourcingEventCode"]//a
    Wait Until Element Is Visible    xpath=${xpath}    10s
    Click Element    xpath=${xpath}
    Log To Console    ✅ Kattintás a(z) ${sor_index}. sor első oszlopában lévő linkre sikeres.
    Sleep    2s    


*** Test Cases ***

ELJÁRÁS oldal megnyitása
    Bejelentkezés admin felhasználóval

Modal ablak kezelése ha van
    Handle Modal Dialog    

Kattintás a három-pont menüre (ellipsis toggle)
    Wait Until Element Is Visible    id=menu_mm_ellipsisToggle    10s
    Click Element    id=menu_mm_ellipsisToggle
    Sleep    1s

Kiválasztjuk az "Eljárás" menüpontot
    Wait Until Element Is Visible    id=menu_mm_MM_CPS_Sourcing    10s
    Click Element    id=menu_mm_MM_CPS_Sourcing
    Sleep    1s

Várjuk, hogy az ag-Grid fő táblázat megjelenjen
    Wait Until Page Contains Element    xpath=//div[contains(@class,"ag-body-container")]/div[contains(@class,"ag-row")]    30s

Kattintás a paraméterben megadott sorra
    Kattintás táblázat sorra    3
    Sleep    2s

Adminisztráció blokk betöltése
# Várjuk, hogy az Adminisztráció a táblázat betöltődjön
    Wait Until Element Is Visible    xpath=//table[@class="OPM_GeneralTable_Table"]    30s
    Sleep    2s

Adminisztráció blokk elemzése
    ${text}=    Get Text    xpath=//table[@class="OPM_GeneralTable_Table"]//td[@title="Eljárás azonosító"]
    Érték szöveg és nem üres    ${text}
    ${text}=    Get Text    xpath=//table[@class="OPM_GeneralTable_Table"]//td[@title="Beszerzési konstrukció"]
    Érték szöveg és nem üres    ${text}
    ${text}=    Get Text    xpath=//table[@class="OPM_GeneralTable_Table"]//td[@title="Az eljárás keretmegállapodás megkötésére irányul?"]
    Érték szöveg és nem üres    ${text}
    ${text}=    Get Text    xpath=//table[@class="OPM_GeneralTable_Table"]//td[@title="Az eljárás keretmegállapodás alapján történő szerződéskötésre irányul?"]
    Érték szöveg és nem üres    ${text}
    ${text}=    Get Text    xpath=//table[@class="OPM_GeneralTable_Table"]//td[@title="Eljárás típus"]
    Érték szöveg és nem üres    ${text}
    ${text}=    Get Text    xpath=//table[@class="OPM_GeneralTable_Table"]//td[@title="Beszerzés tárgya"]
    Érték szöveg és nem üres    ${text}
    ${text}=    Get Text    xpath=//table[@class="OPM_GeneralTable_Table"]//td[@title="Státusz"]
    Érték szöveg és nem üres    ${text}
    ${text}=    Get Text    xpath=//table[@class="OPM_GeneralTable_Table"]//td[@title="Folyamat állapota"]
    Érték szöveg és nem üres    ${text}
    ${text}=    Get Text    xpath=//table[@class="OPM_GeneralTable_Table"]//td[@title="Beszerzés státusz"]
    Érték szöveg és nem üres    ${text}
    ${text}=    Get Text    xpath=//table[@class="OPM_GeneralTable_Table"]//td[@title="Becsült érték (nettó)"]
    Érték szöveg és nem üres    ${text}
    ${text}=    Get Text    xpath=//table[@class="OPM_GeneralTable_Table"]//td[@title="Rendelkezésre álló fedezet összesen (nettó Ft)"]
    Érték szöveg és nem üres    ${text}
    ${text}=    Get Text    xpath=//table[@class="OPM_GeneralTable_Table"]//td[@title="Rendelkezésre álló fedezet összesen (bruttó Ft)"]
    Érték szöveg és nem üres    ${text}
    ${text}=    Get Text    xpath=//table[@class="OPM_GeneralTable_Table"]//td[@title="Pénznem"]
    Érték szöveg és nem üres    ${text}
    ${text}=    Get Text    xpath=//table[@class="OPM_GeneralTable_Table"]//td[@title="Eljárásrend"]
    Érték szöveg és nem üres    ${text}
    ${text}=    Get Text    xpath=//table[@class="OPM_GeneralTable_Table"]//td[@title="Beszerzés tárgyának típusa"]
    Érték szöveg és nem üres    ${text}
    ${text}=    Get Text    xpath=//table[@class="OPM_GeneralTable_Table"]//td[@title="A beszerzés tartalmaz-e, illetve érint-e minősített adatot"]
    Érték szöveg és nem üres    ${text}
    ${text}=    Get Text    xpath=//table[@class="OPM_GeneralTable_Table"]//td[@title="Beszerzés célja"]
    Érték szöveg és nem üres    ${text}
    ${text}=    Get Text    xpath=//table[@class="OPM_GeneralTable_Table"]//td[@title="Fő CPV kód"]
    Érték szöveg és nem üres    ${text}
    ${text}=    Get Text    xpath=//table[@class="OPM_GeneralTable_Table"]//td[@title="Szervező"]
    Érték szöveg és nem üres    ${text}
    ${text}=    Get Text    xpath=//table[@class="OPM_GeneralTable_Table"]//td[@title="Szervezeti egység"]
    Érték szöveg és nem üres    ${text}
    ${text}=    Get Text    xpath=//table[@class="OPM_GeneralTable_Table"]//td[@title="Beszerzési igazgatóság"]
    Érték szöveg és nem üres    ${text}
    Sleep    2s

# Kattintás az első oszlop index szerinti oszlopában lévő linkre
    Kattintás sor linkre    3
    Sleep    10s


Kapcsolódó igények menü kiválasztása
##### Kapcsolódó igények menü kiválasztása
# 1) Kattintás a "Kapcsolódó igények" melletti három pontra
    Wait Until Element Is Visible    xpath=//a[contains(text(),"Kapcsolódó igények")]/following::a[@class="tab_menu_dropdown_link"][1]    10s
    Click Element    xpath=//a[contains(text(),"Kapcsolódó igények")]/following::a[@class="tab_menu_dropdown_link"][1]

# 2) Kattintás a legördülő menüben a "Kapcsolódó igények" elemre (id alapján)
    Wait Until Element Is Visible    xpath=//a[@id="Screen_CPS_SourcingEvent@Screen_CPS_SourcingEventEdit/2//_tab_ConnectedRequisition_Tab"]    10s
    Click Element    xpath=//a[@id="Screen_CPS_SourcingEvent@Screen_CPS_SourcingEventEdit/2//_tab_ConnectedRequisition_Tab"]
    Sleep    5s

Kapcsolódó igények validálása
    Validate Table Headers    3    IGÉNY AZONOSÍTÓ    SZERVEZET    TERVSOR AZONOSÍTÓ    TERVEZETT BESZERZÉS
    Sleep    2s

Részajánlati körök oldal menü kiválasztása
##### Részajánlati körök táblázat validálása
# 1) Kattintás a "Kapcsolódó igények" melletti három pontra
    Wait Until Element Is Visible    xpath=//a[contains(text(),"Kapcsolódó igények")]/following::a[@class="tab_menu_dropdown_link"][1]    10s
    Click Element    xpath=//a[contains(text(),"Kapcsolódó igények")]/following::a[@class="tab_menu_dropdown_link"][1]
    
# 2) Kattintás a legördülő menüben a "Részajánlati körök" elemre (id alapján)
    Wait Until Element Is Visible    xpath=//a[@id="Screen_CPS_SourcingEvent@Screen_CPS_SourcingEventEdit/2//_tab_SubArea_Tab"]    10s
    Click Element    xpath=//a[@id="Screen_CPS_SourcingEvent@Screen_CPS_SourcingEventEdit/2//_tab_SubArea_Tab"]
    Sleep    5s

Részajánlati körök validálása
    Validate Table Headers    3    SORSZÁM    RÉSZAJÁNLATI KÖR NEVE    BECSÜLT ÉRTÉK (NETTÓ FT)    RENDELKEZÉSRE ÁLLÓ NETTÓ FEDEZET (FT)    ÁFA (%)    RENDELKEZÉSRE ÁLLÓ BRUTTÓ FEDEZET (FT)
    Sleep    2s

Résztvevők oldal menü kiválasztása
##### Résztvevők oldal menü kiválasztása
# 1) Kattintás a "Részajánlati körök" melletti három pontra
    Wait Until Element Is Visible    xpath=//a[contains(text(),"Részajánlati körök")]/following::a[@class="tab_menu_dropdown_link"][1]    10s
    Click Element    xpath=//a[contains(text(),"Részajánlati körök")]/following::a[@class="tab_menu_dropdown_link"][1]

# 2) Kattintás a legördülő menüben a "Résztvevők" elemre (id alapján)
    Wait Until Element Is Visible    xpath=//a[@id="Screen_CPS_SourcingEvent@Screen_CPS_SourcingEventEdit/2//_tab_Participants_Tab"]    10s
    Click Element    xpath=//a[@id="Screen_CPS_SourcingEvent@Screen_CPS_SourcingEventEdit/2//_tab_Participants_Tab"]
    Sleep    5s    

Résztvevők validálása
    Validate Table Headers    3    FELHASZNÁLÓ    SZEREPKÖR    SZAKÉRTELEM    BB ELNÖK
    Sleep    2s

Feltételek oldal menü kiválasztása
##### Feltételek táblázat validálása
# 1) Kattintás a "Résztvevők" melletti három pontra
    Wait Until Element Is Visible    xpath=//a[contains(text(),"Résztvevők")]/following::a[@class="tab_menu_dropdown_link"][1]    10s
    Click Element    xpath=//a[contains(text(),"Résztvevők")]/following::a[@class="tab_menu_dropdown_link"][1]

# 2) Kattintás a legördülő menüben a "Feltételek" elemre (id alapján)
    Wait Until Element Is Visible    xpath=//a[@id="Screen_CPS_SourcingEvent@Screen_CPS_SourcingEventEdit/2//_tab_SourcingEventTerm_Tab"]    10s
    Click Element    xpath=//a[@id="Screen_CPS_SourcingEvent@Screen_CPS_SourcingEventEdit/2//_tab_SourcingEventTerm_Tab"]
    Sleep    5s    

Feltételek validálása
    Validate Table Headers    3    FELTÉTEL TÍPUSA    SORSZÁM    ELŐÍRT SZEMPONT, FELTÉTEL    TÍPUS    DOKUMENTUM TÍPUSA  
    Sleep    2s

Beadási dátumok menü kiválasztása
##### Beadási dátumok menü kiválasztása
# 1) Kattintás a "Feltételek" melletti három pontra
    Wait Until Element Is Visible    xpath=//a[contains(text(),"Feltételek")]/following::a[@class="tab_menu_dropdown_link"][1]    10s
    Click Element    xpath=//a[contains(text(),"Feltételek")]/following::a[@class="tab_menu_dropdown_link"][1]

# 2) Kattintás a legördülő menüben a "Beadási dátumok" elemre (id alapján)
    Wait Until Element Is Visible    xpath=//a[@id="Screen_CPS_SourcingEvent@Screen_CPS_SourcingEventEdit/2//_tab_BidSubmissionDate_Tab"]    10s
    Click Element    xpath=//a[@id="Screen_CPS_SourcingEvent@Screen_CPS_SourcingEventEdit/2//_tab_BidSubmissionDate_Tab"]
    Sleep    5s

# Oszlopnevek validálása a táblázatban
    Validate Table Headers    3    SORSZÁM    ELJÁRÁS SZAKASZ NEVE    AJÁNLATADÁS TÍPUSA    BEADÁSI IDŐPONT VÉGE 
    Sleep    2s

Hirdetmény adatok menü kiválasztása
##### Hirdetmény adatok
# 1) Kattintás a "Beadási dátumok" melletti három pontra
    Wait Until Element Is Visible    xpath=//a[contains(text(),"Beadási dátumok")]/following::a[@class="tab_menu_dropdown_link"][1]    10s
    Click Element    xpath=//a[contains(text(),"Beadási dátumok")]/following::a[@class="tab_menu_dropdown_link"][1]

# 2) Kattintás a legördülő menüben a "Hirdetmény adatok" elemre (id alapján)
    Wait Until Element Is Visible    xpath=//a[@id="Screen_CPS_SourcingEvent@Screen_CPS_SourcingEventEdit/2//_tab_Announcement_Tab"]    10s
    Click Element    xpath=//a[@id="Screen_CPS_SourcingEvent@Screen_CPS_SourcingEventEdit/2//_tab_Announcement_Tab"]
    Sleep    5s    

Hirdetmény adatok validálása a táblázatban
    Validate Table Headers    3    HIRDETMÉNY TÍPUSA    HIRDETMÉNY SZÁMA    HIRDETMÉNY FELADÁSÁNAK DÁTUMA    HIÁNYPÓTLÁS TÖRTÉNT?    HIÁNYPÓTLÁS DÁTUMA    MEGJELENÉS DÁTUMA  
    Sleep    2s

Ellenőrzés adatok menü kiválasztása
##### Ellenőrzés adatok
# 1) Kattintás a "Hirdetmény adatok" melletti három pontra
    Wait Until Element Is Visible    xpath=//a[contains(text(),"Hirdetmény adatok")]/following::a[@class="tab_menu_dropdown_link"][1]    10s
    Click Element    xpath=//a[contains(text(),"Hirdetmény adatok")]/following::a[@class="tab_menu_dropdown_link"][1]

# 2) Kattintás a legördülő menüben a "Ellenőrzés adatok" elemre (id alapján)
    Wait Until Element Is Visible    xpath=//a[@id="Screen_CPS_SourcingEvent@Screen_CPS_SourcingEventEdit/2//_tab_Audit_Tab"]    10s
    Click Element    xpath=//a[@id="Screen_CPS_SourcingEvent@Screen_CPS_SourcingEventEdit/2//_tab_Audit_Tab"]
    Sleep    5s    

Ellenőrzés adatok validálása a táblázatban
    Validate Table Headers    3    ELLENŐRZŐ SZERV    ELLENŐRZÉS FORMÁJA    ELLENŐRZÉSRE KÜLDÖTT IRATOK    MEGKÜLDÉS IDŐPONTJA    VÁLASZ DÁTUMA    HATÁRIDŐN BELÜL NEM TETT ÉSZREVÉTELT    ÉSZREVÉTELEZÉSI HATÁRIDŐ LETELTE    HIÁNYPÓTLÁS SZÜKSÉGES?
    Sleep    2s


Dokumentumok menü kiválasztása
##### Dokumentumok
# 1) Kattintás a "Ellenőrzés adatok" melletti három pontra
    Wait Until Element Is Visible    xpath=//a[contains(text(),"Ellenőrzés adatok")]/following::a[@class="tab_menu_dropdown_link"][1]    10s
    Click Element    xpath=//a[contains(text(),"Ellenőrzés adatok")]/following::a[@class="tab_menu_dropdown_link"][1]

# 2) Kattintás a legördülő menüben a "Dokumentumok" elemre (id alapján)
    Wait Until Element Is Visible    xpath=//a[@id="Screen_CPS_SourcingEvent@Screen_CPS_SourcingEventEdit/2//_tab_Documents_Tab"]    10s
    Click Element    xpath=//a[@id="Screen_CPS_SourcingEvent@Screen_CPS_SourcingEventEdit/2//_tab_Documents_Tab"]
    Sleep    5s    

Dokumentumok validálása a táblázatban
    Validate Table Headers    3    LETÖLTÉS    ELŐNÉZET    DOKUMENTUM    IKTATÓSZÁM    KULCSSZAVAK    DOKUMENTUM TÍPUS    FELTÖLTÉS DÁTUMA    FELTÖLTŐ    ÉSZP-N MEGJELENIK?
    Sleep    2s


Kommunikáció menü kiválasztása
##### Kommunikáció
# 1) Kattintás a "Dokumentumok" melletti három pontra
    Wait Until Element Is Visible    xpath=//a[contains(text(),"Ellenőrzés adatok")]/following::a[@class="tab_menu_dropdown_link"][1]    10s
    Click Element    xpath=//a[contains(text(),"Ellenőrzés adatok")]/following::a[@class="tab_menu_dropdown_link"][1]

# 2) Kattintás a legördülő menüben a "Kommunikáció" elemre (id alapján)
    Wait Until Element Is Visible    xpath=//a[@id="Screen_CPS_SourcingEvent@Screen_CPS_SourcingEventEdit/2//_tab_Communications_Tab"]    10s
    Click Element    xpath=//a[@id="Screen_CPS_SourcingEvent@Screen_CPS_SourcingEventEdit/2//_tab_Communications_Tab"]
    Sleep    5s    

Kommunikáció validálása a táblázatban
    Validate Table Headers    3    TÁRGY    CÍMZETT    KIKÜLDÉS DÁTUMA    STÁTUSZ
    Sleep    2s


Jóváhagyók menü kiválasztása
##### Jóváhagyók
# 1) Kattintás a "Kommunikáció" melletti három pontra
    Wait Until Element Is Enabled    xpath=//a[contains(text(),"Kommunikáció")]/following::a[@class="tab_menu_dropdown_link"][1]    10s
    Click Element    xpath=//a[contains(text(),"Kommunikáció")]/following::a[@class="tab_menu_dropdown_link"][1]

# 2) Kattintás a legördülő menüben a "Jóváhagyók" elemre (id alapján)
    Wait Until Element Is Visible    xpath=//a[@id="Screen_CPS_SourcingEvent@Screen_CPS_SourcingEventEdit/2//_tab_Approver_Tab"]    10s
    Click Element    xpath=//a[@id="Screen_CPS_SourcingEvent@Screen_CPS_SourcingEventEdit/2//_tab_Approver_Tab"]
    Sleep    5s    

Jóváhagyók validálása a táblázatban
    Validate Table Headers    3    JÓVÁHAGYÓ    FELADAT NEVE    JÓVÁHAGYÓ SZEREPKÖRE    EREDMÉNY    FELADAT ELVÉGZÉSE 
    Sleep    2s


Ajánlatok táblázat validálása
    Validate Table Headers    4    Gazdasági szereplő azonosító    Gazdasági szereplő neve    Státusz    Ajánlat nettó összege    Ajánlat bruttó összege    Pénznem    Benyújtás dátuma    Típus    Eljárás szakasz sorszáma    Eljárás szakasz    Keretmegállapodás / dbr azonosító
    Sleep    2s

##### Ajánlat sorok áttekintése gomb megnyomása
Ajánlat sorok áttekintése gomb megnyomása
    Wait Until Element Is Visible    xpath=//button[@id="Screen_CPS_SourcingEvent@Screen_CPS_SourcingEventEdit/3/SourcingEventBid_Tab/BidLines"]    10s
    Wait Until Element Is Enabled    xpath=//button[@id="Screen_CPS_SourcingEvent@Screen_CPS_SourcingEventEdit/3/SourcingEventBid_Tab/BidLines"]    10s
    Click Element    xpath=//button[@id="Screen_CPS_SourcingEvent@Screen_CPS_SourcingEventEdit/3/SourcingEventBid_Tab/BidLines"]
    Sleep    3s

Ajánlat sorok áttekintése, Tételek táblázat validálása
    Validate Table Headers    5    MEGNEVEZÉS    MENNYISÉG    EGYSÉG    TELJESÍTÉSI HATÁRIDŐ    EGYÉB INFORMÁCIÓ    MEGJEGYZÉSEK  
    Sleep    1s   

# Ajánlat sorok áttekintése, Ajánlati elemek összesítése táblázat validálása?????

# Kilépés az Ajánlat sorok áttekintése ablakból az ESCAPE gombbal
    Press Keys    xpath=//body    ESCAPE
    Sleep    1s


##### Ajánlat feltételek áttekintése gomb megnyomása
Ajánlat feltételek áttekintése gomb megnyomása
    Wait Until Element Is Visible    xpath=//button[@id="Screen_CPS_SourcingEvent@Screen_CPS_SourcingEventEdit/3/SourcingEventBid_Tab/TermLines"]    10s
    Wait Until Element Is Enabled    xpath=//button[@id="Screen_CPS_SourcingEvent@Screen_CPS_SourcingEventEdit/3/SourcingEventBid_Tab/TermLines"]    10s
    Click Element    xpath=//button[@id="Screen_CPS_SourcingEvent@Screen_CPS_SourcingEventEdit/3/SourcingEventBid_Tab/TermLines"]
    Sleep    2s

Ajánlat feltételek áttekintése táblázat validálása
    Validate Table Headers    5    FELTÉTEL TÍPUSA    ELŐÍRT SZEMPONT, FELTÉTEL  
    Sleep    1s  

# Ajánlati fetételek táblázat ban az első sor kiválasztása
    Click Element    xpath=(//div[@id="Screen_CPS_SourcingEvent@Screen_CPS_SourcingEventEdit@Screen_CPS_SourcingEventTermOverView/1//_activeTab"]//div[contains(@class,"ag-body-container")]/div[contains(@class,"ag-row")])[2]
    Sleep    2s 
         
# Kilépés az Ajánlati feltételek áttekintése ablakból az ESCAPE gombbal
    Press Keys    xpath=//body    ESCAPE
    Sleep    1s


##### Eljárás eredménye gomb megnyomása
Eljárás eredménye gomb megnyomása
    Wait Until Element Is Visible    xpath=//button[@id="Screen_CPS_SourcingEvent@Screen_CPS_SourcingEventEdit/3/SourcingEventBid_Tab/SourcingEventResult"]    10s
    Wait Until Element Is Enabled    xpath=//button[@id="Screen_CPS_SourcingEvent@Screen_CPS_SourcingEventEdit/3/SourcingEventBid_Tab/SourcingEventResult"]    10s
    Click Element    xpath=//button[@id="Screen_CPS_SourcingEvent@Screen_CPS_SourcingEventEdit/3/SourcingEventBid_Tab/SourcingEventResult"]
    Sleep    2s

Eljárás eredmények táblázat validálása
    Validate Table Headers    5    SORSZÁM    RÉSZAJÁNLATI KÖR NEVE    EREDMÉNY  
    Sleep    1s  

# Eljárás eredménye táblázatban az első sor kiválasztása
    #Click Element    xpath=(//div[@id="Screen_CPS_SourcingEvent@Screen_CPS_SourcingEventEdit@Screen_CPS_SourcingEventTermOverView/1//_activeTab"]//div[contains(@class,"ag-body-container")]/div[contains(@class,"ag-row")])[2]
    Sleep    2s 
         
# Kilépés az Eljárás eredménye ablakból az ESCAPE gombbal
    Press Keys    xpath=//body    ESCAPE
    Sleep    1s    