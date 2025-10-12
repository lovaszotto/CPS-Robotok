*** Settings ***
Library    SeleniumLibrary
Resource    ../resources/cps30_login.resource

*** Variables ***
${URL}    https://172.28.30.5/cps30/MM_CPS_Sourcing/Screen_CPS_SourcingEvent

*** Test Cases ***
Beszerzési eljárás azonosító szöveg ellenőrzése
    Bejelentkezés admin felhasználóval
    Go To    ${URL}
    Wait Until Page Contains    Beszerzési eljárás azonosító    10s
    Log To Console    SIKER: A szöveg megtalálható az oldalon!
