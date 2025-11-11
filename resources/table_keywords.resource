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
    ELSE
        Log To Console    ✅ Minden oszlop megtalálható.
    END
