*** Settings ***
Library    SeleniumLibrary
Resource    ../resources/cps30_login.resource

*** Variables ***
${URL}    https://172.28.30.5/cps30/MM_CPS_Sourcing/Screen_CPS_SourcingEvent

*** Settings ***
Library    SeleniumLibrary
Resource    ../resources/cps30_login.resource

*** Variables ***
${URL}    https://172.28.30.5/cps30/MM_CPS_Sourcing/Screen_CPS_SourcingEvent

*** Test Cases ***

CPS30 ELJÁRÁS oldal megnyitása
     Bejelentkezés admin felhasználóval
    # Go To    https://172.28.30.5/cps30/MM_CPS_Sourcing/Screen_CPS_SourcingEvent
     Go To     https://172.28.30.5/cps30/MM_CPS_Sourcing/Screen_CPS_SourcingEvent?d1=%7CMM_CPS_Sourcing%7CScreen_CPS_SourcingEventEdit%7Cin%7C%7CEditObject%7C%7C1493%7C%7C%5B%7B%22a%22:%22SourcingEvent_ID%22,%22t%22:1,%22v%22:52%7D,%7B%22a%22:%22SourcingEventResultType_ID%22,%22t%22:2,%22v%22:%22%22%7D,%7B%22a%22:%22Company_ID%22,%22t%22:2,%22v%22:14%7D,%7B%22a%22:%22SourcingPlanDetails_ID%22,%22t%22:2,%22v%22:94%7D,%7B%22a%22:%22RequisitionType_ID%22,%22t%22:2,%22v%22:2%7D,%7B%22a%22:%22Bidding_On_VendorPortal%22,%22t%22:2,%22v%22:false%7D,%7B%22a%22:%22Template__CPS_SourcingEvent%22,%22t%22:2,%22v%22:%22_OPM_SourcingEventfrg%22%7D,%7B%22a%22:%22ParentBO_Type%22,%22t%22:2,%22v%22:%22_CPS_SourcingEvent%22%7D,%7B%22a%22:%22BO_ID%22,%22t%22:2,%22v%22:52%7D,%7B%22a%22:%22BO_Type%22,%22t%22:2,%22v%22:%22_OPM_SourcingEventfrg%22%7D,%7B%22a%22:%22Entity_Name%22,%22t%22:2,%22v%22:%22SourcingEvent%22%7D,%7B%22a%22:%22Entity_ID%22,%22t%22:2,%22v%22:52%7D,%7B%22a%22:%22JumpType%22,%22t%22:2,%22v%22:1%7D%5D

     Wait Until Element Is Visible    xpath=//button[@title='Új ajánlat']    15s
     Click Element    xpath=//button[@title='Új ajánlat']

     Wait Until Page Contains     Ajánlat / részvételi jelentkezés     20s
     
    
Ajánlat adatlap ellenőrzése
     [Tags]  Ajánlat adatlap
     Wait Until Keyword Succeeds    10s    1s    Page Should Contain Element    xpath=//*[contains(translate(text(), 'ABCDEFGHIJKLMNOPQRSTUVWXYZÁÉÍÓÖŐÚÜŰ', 'abcdefghijklmnopqrstuvwxyzáéíóöőúüű'), 'ajánlat / részvételi jelentkezés')]

Beszerzési eljárás azonosító szöveg ellenőrzése
     [Tags]  ADMINISZTRÁCIÓ
     Wait Until Keyword Succeeds    10s    1s    Page Should Contain Element    xpath=//*[contains(translate(text(), 'ABCDEFGHIJKLMNOPQRSTUVWXYZÁÉÍÓÖŐÚÜŰ', 'abcdefghijklmnopqrstuvwxyzáéíóöőúüű'), 'beszerzési eljárás azonosító')]

Beszerzési eljárás típus szöveg ellenőrzése
     [Tags]  ADMINISZTRÁCIÓ
     Wait Until Keyword Succeeds    10s    1s    Page Should Contain Element    xpath=//*[contains(translate(text(), 'ABCDEFGHIJKLMNOPQRSTUVWXYZÁÉÍÓÖŐÚÜŰ', 'abcdefghijklmnopqrstuvwxyzáéíóöőúüű'), 'beszerzési eljárás típus')]

Beszerzés tárgya szöveg ellenőrzése
     Wait Until Keyword Succeeds    10s    1s    Page Should Contain Element    xpath=//*[contains(translate(text(), 'ABCDEFGHIJKLMNOPQRSTUVWXYZÁÉÍÓÖŐÚÜŰ', 'abcdefghijklmnopqrstuvwxyzáéíóöőúüű'), 'beszerzés tárgya')]

Eljárás státusza szöveg ellenőrzése
      [Tags]  ADMINISZTRÁCIÓ
     Wait Until Keyword Succeeds    10s    1s    Page Should Contain Element    xpath=//*[contains(translate(text(), 'ABCDEFGHIJKLMNOPQRSTUVWXYZÁÉÍÓÖŐÚÜŰ', 'abcdefghijklmnopqrstuvwxyzáéíóöőúüű'), 'eljárás státusza')]

Ajánlattételi lehetőség az Ajánlattevői portálon? szöveg ellenőrzése
     Wait Until Keyword Succeeds    10s    1s    Page Should Contain Element    xpath=//*[contains(translate(text(), 'ABCDEFGHIJKLMNOPQRSTUVWXYZÁÉÍÓÖŐÚÜŰ', 'abcdefghijklmnopqrstuvwxyzáéíóöőúüű'), 'ajánlattételi lehetőség az ajánlattevői portálon?')]

Szervező szöveg ellenőrzése
      [Tags]  ADMINISZTRÁCIÓ
     Wait Until Page Contains    Szervező    1s

Pénznem szöveg ellenőrzése
      [Tags]  ADMINISZTRÁCIÓ
     Wait Until Page Contains    Pénznem    1s

Megjegyzések szöveg ellenőrzése
  [Tags]  ADMINISZTRÁCIÓ
     Wait Until Page Contains    Megjegyzések    1s

AJÁNLAT/RÉSZVÉTELI JELENTKEZÉS ADATOK  szöveg ellenőrzése
  [Tags]  AJÁNLAT/RÉSZVÉTELI JELENTKEZÉS ADATOK
     Wait Until Page Contains    AJÁNLAT/RÉSZVÉTELI JELENTKEZÉS ADATOK    1s

Gazdasági szereplő azonosító szöveg ellenőrzése
     [Tags]  AJÁNLAT/RÉSZVÉTELI JELENTKEZÉS ADATOK
     Wait Until Page Contains    Gazdasági szereplő azonosító    1s

Gazdasági szereplő neve szöveg ellenőrzése
     Wait Until Page Contains    Gazdasági szereplő neve    1s

Kapcsolattartó szöveg ellenőrzése
     Wait Until Page Contains    Kapcsolattartó    1s

Portál felhasználó szöveg ellenőrzése
     Wait Until Page Contains    Portál felhasználó    1s

Konzorcium? szöveg ellenőrzése
     Wait Until Page Contains    Konzorcium?    1s

Konzorcium további résztvevői szöveg ellenőrzése
     Wait Until Page Contains    Konzorcium további résztvevői    1s

Státusz szöveg ellenőrzése
     Wait Until Page Contains    Státusz    1s

Típus szöveg ellenőrzése
     Wait Until Page Contains    Típus    1s

Eljárás szakasz neve szöveg ellenőrzése
     Wait Until Page Contains    Eljárás szakasz neve    1s

Benyújtás dátuma szöveg ellenőrzése
     Wait Until Page Contains    Benyújtás dátuma    1s

Ajánlat nettó összege (valamennyi részre összesen) szöveg ellenőrzése
     Wait Until Page Contains    Ajánlat nettó összege (valamennyi részre összesen)    1s

Ajánlat bruttó összege (valamennyi részre összesen) szöveg ellenőrzése
     Wait Until Page Contains    Ajánlat bruttó összege (valamennyi részre összesen)    1s

Keretmegállapodás azonosító szöveg ellenőrzése
     Wait Until Page Contains    Keretmegállapodás azonosító    1s

ELJÁRÁS DÁTUMOK szöveg ellenőrzése
     Wait Until Page Contains    ELJÁRÁS DÁTUMOK    1s

Beadási időpont kezdete szöveg ellenőrzése
     Wait Until Page Contains    Beadási időpont kezdete    1s

Benyújtási határidő szöveg ellenőrzése
     Wait Until Page Contains    Benyújtási határidő    1s

Részvételi jelentkezések bontásának időpontja szöveg ellenőrzése
     Wait Until Page Contains    Részvételi jelentkezések bontásának időpontja    1s

Ajánlatok bontásának időpontja szöveg ellenőrzése
     Wait Until Page Contains    Ajánlatok bontásának időpontja    1s

