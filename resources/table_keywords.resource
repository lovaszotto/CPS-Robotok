*** Settings ***
Library    String

*** Keywords ***
Validate Table Columns
    [Arguments]    @{expected_columns}
    ${header_elements}=    Run Keyword And Continue On Failure    Get WebElements    xpath=//div[contains(@class,"dgvc_datatable_wrapper")]//span[contains(@class,"grid_header_text")]
    ${actual_columns}=    Run Keyword And Continue On Failure    Create List
    FOR    ${el}    IN    @{header_elements}
        ${text}=    Run Keyword And Continue On Failure    Get Text    ${el}
        ${text}=    Strip String    ${text}
        ${actual_columns}=    Run Keyword And Continue On Failure    Set Variable    ${actual_columns} + [${text}]
    END
    Run Keyword And Continue On Failure    Log    Actual columns: ${actual_columns}
    FOR    ${col}    IN    @{expected_columns}
        ${col}=    Strip String    ${col}
        Run Keyword And Continue On Failure    Should Contain    ${actual_columns}    ${col}
    END

