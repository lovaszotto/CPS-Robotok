*** Settings ***
Library    SeleniumLibrary
Library    RPA.Excel.Files
Resource    ../resources/cps30_login.resource

*** Variables ***
${URL}    https://172.28.30.5/cps30/MM_CPS_Sourcing/Screen_CPS_SourcingEvent
${EXCEL_PATH}    ./eljárás.xlsx
${SHEET_NAME}    Eljárás

*** Test Cases ***
Adatok oszlop szövegeinek ellenőrzése
    Bejelentkezés admin felhasználóval
    Go To    ${URL}
    Open Workbook    ${EXCEL_PATH}
    ${rows}=    Read Worksheet    name=${SHEET_NAME}    header=True
    Log To Console    --- Beolvasott sorok az Excelből: ${rows}
    ${index}=    Set Variable    0
    FOR    ${row}    IN    @{rows}
        Log To Console    \n${index} Sor: ${row}
        ${is_dict}=    Evaluate    isinstance(${row}, dict)
        Log To Console    --- Sor típusa: ${is_dict}
        IF    ${is_dict} and 'Adatok' in ${row}
            ${adat}=    Get From Dictionary    ${row}    Adatok
            ${adat_str}=    Convert To String    ${adat}
            Log To Console    --- Adat érték: ${adat_str}
            ${skip}=    Evaluate    not isinstance(${adat_str}, str) or not ${adat_str} or ${adat_str} == 'None' or ${adat_str} == '0' or ${adat_str} == 0 or str(${adat_str}).strip() == ''
            Log To Console    --- SKIP érték: ${skip}
            IF    not ${skip}
                Log To Console    --- Sor feldolgozva: ${adat_str}
                ${eredmeny}=    Set Variable    ''
                ${status}=    Set Variable    FAIL
                Log To Console    Ellenőrzés: ${adat_str}
                ${found}=    Run Keyword And Return Status    Wait Until Page Contains    ${adat_str}    10s
                Log To Console    --- found: ${found}
                ${found_bool}=    Evaluate    bool(${found})
                IF    ${found_bool}
                    ${status}=    Set Variable    PASS
                ELSE
                   ${status}=    Set Variable    FAIL
                END
                Log To Console    --- status: ${status}
                IF    '${status}' == 'FAIL'
                    Log To Console    HIBA: Nem található: ${adat_str}
                    Set Variable    ${eredmeny}    SIKERTELEN
                ELSE IF    '${status}' == 'PASS'
                    Log To Console    SIKER: Megtalálva: ${adat_str}
                    Set Variable    ${eredmeny}    SIKERES
                END
                ${write_ok}=    Evaluate    bool(${eredmeny}) and str(${eredmeny}).strip() != '' and str(${eredmeny}) != 'None'
                Log To Console    --- write_ok: ${write_ok}
                ${cell_index}=    Evaluate    ${index} + 1
                Log To Console    --- cell_index: ${cell_index}
                Run Keyword If    ${write_ok} and ${cell_index} > 0    Write To Cell    ${EXCEL_PATH}    ${SHEET_NAME}    A${cell_index}    ${eredmeny}
            ELSE
                Log To Console    --- Sor kihagyva, mert nem szöveg, üres, None, 0 vagy csak szóköz! (${adat_str})
            END
        ELSE
            Log To Console    --- Sor kihagyva, mert nem dict vagy nincs 'B' kulcs!
        END
        ${index}=    Evaluate    ${index} + 1
    END
    Close Workbook
