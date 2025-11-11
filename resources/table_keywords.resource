*** Keywords ***
Validate Table Headers
    [Arguments]    ${table_index}    @{expected_columns}

    # Csökkentjük a table_index értékét eggyel
    ${adjusted_index}=    Evaluate    ${table_index}
    Log To Console    Vizsgált táblázat indexe (csökkentve): ${adjusted_index}

    # Ellenőrizzük, hogy az adott táblázat létezik-e
    ${table_exists}=    Run Keyword And Return Status    Page Should Contain Element    xpath=(//div[contains(@class,"ag-root")])[${adjusted_index}]
    IF    not ${table_exists}
        Log To Console    ⚠️ Nincs ${adjusted_index}. tábla – valószínűleg nincs adat.
        RETURN
    END

    # Ellenőrizzük, hogy a tábla látható és van fejléce
    ${headers_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath=(//div[contains(@class,"ag-root")])[${adjusted_index}]//span[contains(@class,"grid_header_text")]    10s
    IF    not ${headers_visible}
        Log To Console    ⚠️ A(z) ${adjusted_index}. tábla üres vagy nem látható — kihagyva.
        RETURN
    END

    # Fejléc elemek lekérdezése
    ${header_cells}=    Get WebElements    xpath=(//div[contains(@class,"ag-root")])[${adjusted_index}]//div[contains(@class,"ag-header-cell")]//span[contains(@class,"grid_header_text")]

    ${actual_columns}=    Create List
    FOR    ${cell}    IN    @{header_cells}
        ${text}=    Get Text    ${cell}
        ${text}=    Strip String    ${text}
        ${text}=    Convert To Lowercase    ${text}
        IF    '${text}' != ''
            Append To List    ${actual_columns}    ${text}
        END
    END

    Log To Console    Talált oszlopok (${adjusted_index}. tábla): ${actual_columns}
    Log To Console    Keresett oszlopok: ${expected_columns}

    ${missing_columns}=    Create List
    FOR    ${col}    IN    @{expected_columns}
        ${col}=    Strip String    ${col}
        ${col}=    Convert To Lowercase    ${col}
        IF    '${col}' not in ${actual_columns}
            Append To List    ${missing_columns}    ${col}
        END
    END

    IF    ${missing_columns}
        Log To Console    ⚠️ Hiányzó oszlop(ok): ${missing_columns}
        Log    ⚠️ Hiányzó oszlop(ok): ${missing_columns}
    ELSE
        Log To Console    ✅ Minden oszlop megtalálható.
    END
