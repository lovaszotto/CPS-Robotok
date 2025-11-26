*** Keywords ***
Validate Table Headers
    [Arguments]    ${table_index}    @{expected_columns}

    # Csökkentjük a table_index értékét (JS indexelés miatt)
    ${adjusted_index}=    Evaluate    ${table_index}
    Log To Console    Vizsgált táblázat indexe (csökkentve): ${adjusted_index}

    # Ellenőrizzük, hogy az adott tábla létezik
    ${table_exists}=    Run Keyword And Return Status    Page Should Contain Element    xpath=(//div[contains(@class,"ag-root")])[${adjusted_index}]
    IF    not ${table_exists}
        Log To Console    ⚠️ Nincs ${adjusted_index}. tábla – valószínűleg nincs adat.
        RETURN
    END

    # Ellenőrizzük, hogy a tábla látható
    ${headers_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath=(//div[contains(@class,"ag-root")])[${adjusted_index}]    10s
    IF    not ${headers_visible}
        Log To Console    ⚠️ A(z) ${adjusted_index}. tábla üres vagy nem látható — kihagyva.
        RETURN
    END

    # 🔹 Fejléc oszlopok kinyerése JavaScript-tel (minden oszlopot lát, nemcsak a láthatókat)
    ${script}=    Catenate
    ...    var root=document.querySelectorAll('div.ag-root')[${adjusted_index}-1];
    ...    if(!root)return[];
    ...    return Array.from(root.querySelectorAll('span.grid_header_text, span.grid_header_text_no_sort')).map(e => e.textContent.trim());
    ${actual_columns}=    Execute JavaScript    ${script}

    # Normalizálás (kisbetű, space trim)
    ${normalized_columns}=    Create List
    FOR    ${col}    IN    @{actual_columns}
        ${col}=    Strip String    ${col}
        ${col}=    Convert To Lowercase    ${col}
        IF    '${col}' != ''
            Append To List    ${normalized_columns}    ${col}
        END
    END

    Log To Console    Talált oszlopok (${adjusted_index}. tábla): ${normalized_columns}

    # Normalizáljuk a keresett oszlopokat is
    ${normalized_expected}=    Create List
    FOR    ${col}    IN    @{expected_columns}
        ${col}=    Strip String    ${col}
        ${col}=    Convert To Lowercase    ${col}
        Append To List    ${normalized_expected}    ${col}
    END
    Log To Console    Keresett oszlopok: ${normalized_expected}

    # Hiányzó oszlopok ellenőrzése
    ${missing_columns}=    Create List
    FOR    ${col}    IN    @{normalized_expected}
        IF    '${col}' not in ${normalized_columns}
            Append To List    ${missing_columns}    ${col}
        END
    END

    IF    ${missing_columns}
        Log To Console    ⚠️ Hiányzó oszlop(ok): ${missing_columns}
        Log    ⚠️ Hiányzó oszlop(ok): ${missing_columns}
        Fail    ❌ Hiányzó oszlop(ok): ${missing_columns}
    ELSE
        Log To Console    ✅ Minden oszlop megtalálható.
    END

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
Kattintás táblázat sorra azonosító alapján
    [Arguments]    ${link_nev}
    Log To Console    🔍 Keresett link neve: ${link_nev}

    # Gyűjtsük ki az összes sor link szövegét az első oszlopból (SourcingEventCode)
    ${links}=    Get WebElements    xpath=//div[contains(@class,"ag-body-container")]//div[contains(@class,"ag-row")]//div[@colid="SourcingEventCode"]//a

    ${sor_index}=    Set Variable    0
    ${i}=    Set Variable    1

    # Végigmegyünk az összes linken
    FOR    ${link}    IN    @{links}
        ${text}=    Get Text    ${link}
        ${text}=    Strip String    ${text}
        Run Keyword And Continue On Failure    Log To Console    Ellenőrzött link (${i}): ${text}

        ${match}=    Run Keyword And Return Status    Should Contain    ${text}    ${link_nev}
        IF    ${match}
            ${sor_index}=    Set Variable    ${i}
            Exit For Loop
        END
        ${i}=    Evaluate    ${i} + 1
    END

    # Ha nem találtunk linket
    IF    ${sor_index} == 0
        Fail    ⚠️ Nem találtunk sor linket az azonosítóval: ${link_nev}
    END

    # Kattintás a JS-es működő sorszámos módszerrel
    Wait Until Element Is Visible    xpath=(//div[contains(@class,"ag-body-container")]/div[contains(@class,"ag-row")])[${sor_index}]    5s
    Execute JavaScript    document.evaluate('(//div[contains(@class,"ag-body-container")]/div[contains(@class,"ag-row")])[${sor_index}]', document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.click();
    Log To Console    ✅ Kattintás a(z) ${sor_index}. sorra sikeres.
    Sleep    2s


*** Keywords ***
Kattintás erre az azonosító linkre
    [Arguments]    ${link_nev}
    Log To Console    🔍 Keresett link neve: ${link_nev}

    # Gyűjtsük ki az összes linket az első oszlopból, ahol a colid = SourcingEventCode
    ${links}=    Get WebElements    xpath=//div[contains(@class,"ag-body-container")]//div[contains(@class,"ag-row")]//div[@colid="SourcingEventCode"]//a

    ${count}=    Get Length    ${links}
    Log To Console    🔢 Összes link száma az első oszlopban: ${count}

    ${found}=    Set Variable    0

    # Végigmegyünk az összes linken
    FOR    ${link}    IN    @{links}
        ${text}=    Get Text    ${link}
        ${text}=    Strip String    ${text}

        Run Keyword And Continue On Failure    Log To Console    Ellenőrzött link: ${text}

        # Ha a link szövege tartalmazza a keresett nevet → kattintás
        ${match}=    Run Keyword And Return Status    Should Contain    ${text}    ${link_nev}
        IF    ${match}
            Scroll Element Into View    ${link}
            Wait Until Element Is Visible    ${link}    5s
            Click Element    ${link}
            Log To Console    ✅ Kattintás a linkre: ${text}
            Sleep    1s
            ${found}=    Evaluate    ${found} + 1
        END
    END

    # Összegzés
    IF    ${found} > 0
        Log To Console    🎯 Összesen ${found} egyező linkre kattintottunk.
    ELSE
        Log To Console    ⚠️ Nem találtunk egyező linket a "${link_nev}" kifejezéssel.
    END

*** Keywords ***
Kilépés az ablakból az ESCAPE gombbal
    Press Keys    xpath=//body    ESCAPE
    Sleep    1s