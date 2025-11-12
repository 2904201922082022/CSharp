*** Settings ***
Documentation     Automated NxM UI coverage for Opportunity and Quote creation across all quote scenarios.
Library           SeleniumLibrary    timeout=20 seconds    run_on_failure=Capture Page Screenshot
Suite Setup       Launch And Authenticate Into NxM
Suite Teardown    Close Browser Session
Test Setup        Reset To Opportunity Workspace
Test Teardown     Return To Opportunity Workspace If Possible

*** Variables ***
${NXM_URL}                       https://563603-sb2.app.netsuite.com
${USER_EMAIL}                    vitor.santos@caddmicrosystems.com
${USER_PASSWORD}                 d7npBBiAj66sj9x
${BROWSER}                       chrome
${DEFAULT_TIMEOUT}               20s
${GLOBAL_SEARCH_QUERY_TIMEOUT}   10s

${LOGIN_EMAIL_FIELD}             id=email
${LOGIN_PASSWORD_FIELD}          id=password
${LOGIN_BUTTON}                  xpath=//button[normalize-space()='Login']
${SECURITY_QUESTION_LABEL}       xpath=//div[contains(@class,'challenge-question')]//label
${SECURITY_ANSWER_FIELD}         id=secretanswer
${SECURITY_SUBMIT_BUTTON}        xpath=//button[normalize-space()='Submit']
${DASHBOARD_INDICATOR}           xpath=//div[contains(@class,'global-header')]

${GLOBAL_SEARCH_FIELD}           id=global_search
${GLOBAL_SEARCH_RESULT_LINK}     xpath=//div[contains(@class,'global-search-results')]//a[contains(@href,'oppor')][1]
${NEW_OPPORTUNITY_BUTTON}        xpath=//button[normalize-space()='New Opportunity']
${OPPORTUNITY_CUSTOMER_FIELD}    id=entity_display
${OPPORTUNITY_STATUS_FIELD}      id=entitystatus_display
${OPPORTUNITY_TITLE_FIELD}       id=title
${OPPORTUNITY_SAVE_BUTTON}       id=btn_secondarysave

${QUOTE_SUBTABS_MENU}            xpath=//a[contains(@id,'custpage_quote_subtab')]
${QUOTE_NEW_BUTTON}              xpath=//button[contains(@id,'custpage_new_quote')]
${QUOTE_TYPE_DROPDOWN}           id=custbody_quote_type_display
${QUOTE_START_DATE_FIELD}        id=trandate
${QUOTE_END_DATE_FIELD}          id=duedate
${QUOTE_SUBMIT_BUTTON}           id=submitter
${QUOTE_CONFIRMATION_MESSAGE}    xpath=//div[contains(@class,'alert-success')]

${OPPORTUNITY_LISTING_BREADCRUMB}    xpath=//a[contains(@href,'opporlist')]
${HOME_ICON}                         xpath=//a[contains(@id,'ns-header-home')]

&{SECURITY_ANSWERS}    What was your childhood nickname?=Bia
...                    In what city did you meet your spouse/significant other?=Rio
...                    What is your maternal grandmother's maiden name?=Enedina

&{QUOTE_TYPE_METADATA}    New.title_suffix=New Quote
...                       New.status=01-New
...                       New.term_months=12
...                       Renewal.title_suffix=Renewal Quote
...                       Renewal.status=02-Renewal
...                       Renewal.term_months=12
...                       Co-Term.title_suffix=Co-Term Quote
...                       Co-Term.status=03-Co-Term
...                       Co-Term.term_months=6
...                       Extension.title_suffix=Extension Quote
...                       Extension.status=04-Extension
...                       Extension.term_months=3
...                       Mixed.title_suffix=Mixed Quote
...                       Mixed.status=05-Mixed
...                       Mixed.term_months=12
...                       True-Up.title_suffix=True-Up Quote
...                       True-Up.status=06-True-Up
...                       True-Up.term_months=12
...                       DDA.title_suffix=DDA Quote
...                       DDA.status=07-DDA
...                       DDA.term_months=12

*** Test Cases ***
Create Opportunity And New Quote
    [Tags]    smoke    new_quote
    Create Opportunity For Quote Type    New
    Create Quote For Current Opportunity    New
    Validate Quote Created Successfully    New

Create Opportunity And Renewal Quote
    [Tags]    regression    renewal_quote
    Create Opportunity For Quote Type    Renewal
    Create Quote For Current Opportunity    Renewal
    Validate Quote Created Successfully    Renewal

Create Opportunity And Co-Term Quote
    [Tags]    regression    co_term_quote
    Create Opportunity For Quote Type    Co-Term
    Create Quote For Current Opportunity    Co-Term
    Validate Quote Created Successfully    Co-Term

Create Opportunity And Extension Quote
    [Tags]    regression    extension_quote
    Create Opportunity For Quote Type    Extension
    Create Quote For Current Opportunity    Extension
    Validate Quote Created Successfully    Extension

Create Opportunity And Mixed Quote
    [Tags]    regression    mixed_quote
    Create Opportunity For Quote Type    Mixed
    Create Quote For Current Opportunity    Mixed
    Validate Quote Created Successfully    Mixed

Create Opportunity And True-Up Quote
    [Tags]    regression    true_up_quote
    Create Opportunity For Quote Type    True-Up
    Create Quote For Current Opportunity    True-Up
    Validate Quote Created Successfully    True-Up

Create Opportunity And DDA Quote
    [Tags]    regression    dda_quote
    Create Opportunity For Quote Type    DDA
    Create Quote For Current Opportunity    DDA
    Validate Quote Created Successfully    DDA

*** Keywords ***
Launch And Authenticate Into NxM
    Open Browser    ${NXM_URL}    ${BROWSER}
    Maximize Browser Window
    Wait Until Element Is Visible    ${LOGIN_EMAIL_FIELD}    ${DEFAULT_TIMEOUT}
    Input Text    ${LOGIN_EMAIL_FIELD}    ${USER_EMAIL}
    Input Text    ${LOGIN_PASSWORD_FIELD}    ${USER_PASSWORD}
    Click Button    ${LOGIN_BUTTON}
    Handle Security Challenge If Prompted
    Wait Until Page Contains Element    ${DASHBOARD_INDICATOR}    ${DEFAULT_TIMEOUT}

Handle Security Challenge If Prompted
    ${challenge_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${SECURITY_QUESTION_LABEL}    5s
    Run Keyword If    ${challenge_visible}    Answer Security Question

Answer Security Question
    ${question_text}=    Get Text    ${SECURITY_QUESTION_LABEL}
    ${answer}=    Fetch Security Answer    ${question_text}
    Input Text    ${SECURITY_ANSWER_FIELD}    ${answer}
    Click Button    ${SECURITY_SUBMIT_BUTTON}

Fetch Security Answer
    [Arguments]    ${question_text}
    FOR    ${key}    IN    @{SECURITY_ANSWERS.keys()}
        ${matches}=    Run Keyword And Return Status    Should Contain    ${question_text}    ${key}
        IF    ${matches}
            ${answer}=    Get From Dictionary    ${SECURITY_ANSWERS}    ${key}
            [Return]    ${answer}
        END
    END
    Fail    No security answer mapped for question: ${question_text}

Reset To Opportunity Workspace
    ${dashboard_accessible}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${HOME_ICON}    3s
    Run Keyword If    ${dashboard_accessible}    Click Element    ${HOME_ICON}
    Wait Until Element Is Visible    ${GLOBAL_SEARCH_FIELD}    ${DEFAULT_TIMEOUT}
    Go To Opportunity Workspace

Return To Opportunity Workspace If Possible
    Run Keyword And Ignore Error    Go To Opportunity Workspace

Go To Opportunity Workspace
    Focus Global Search
    Clear Element Text    ${GLOBAL_SEARCH_FIELD}
    Input Text    ${GLOBAL_SEARCH_FIELD}    Opportunity: New
    Wait Until Page Contains Element    ${GLOBAL_SEARCH_RESULT_LINK}    ${GLOBAL_SEARCH_QUERY_TIMEOUT}
    Click Element    ${GLOBAL_SEARCH_RESULT_LINK}
    Wait Until Element Is Visible    ${NEW_OPPORTUNITY_BUTTON}    ${DEFAULT_TIMEOUT}

Focus Global Search
    Wait Until Element Is Visible    ${GLOBAL_SEARCH_FIELD}    ${DEFAULT_TIMEOUT}
    Click Element    ${GLOBAL_SEARCH_FIELD}

Create Opportunity For Quote Type
    [Arguments]    ${quote_type}
    Click Element    ${NEW_OPPORTUNITY_BUTTON}
    Wait Until Element Is Visible    ${OPPORTUNITY_CUSTOMER_FIELD}    ${DEFAULT_TIMEOUT}
    Populate Opportunity Header Fields    ${quote_type}
    Save Opportunity Draft

Populate Opportunity Header Fields
    [Arguments]    ${quote_type}
    ${title_suffix}=    Get From Dictionary    ${QUOTE_TYPE_METADATA}    ${quote_type}.title_suffix
    ${status_value}=    Get From Dictionary    ${QUOTE_TYPE_METADATA}    ${quote_type}.status
    ${term_months}=    Get From Dictionary    ${QUOTE_TYPE_METADATA}    ${quote_type}.term_months
    ${timestamp}=    Get Time    result_format=%Y%m%d%H%M%S
    Input Text    ${OPPORTUNITY_CUSTOMER_FIELD}    Auto Customer ${timestamp}
    Wait Until Page Contains    Auto Customer ${timestamp}    ${DEFAULT_TIMEOUT}
    Press Keys    ${OPPORTUNITY_CUSTOMER_FIELD}    RETURN
    Input Text    ${OPPORTUNITY_TITLE_FIELD}    Auto Opportunity ${title_suffix} ${timestamp}
    Input Text    ${OPPORTUNITY_STATUS_FIELD}    ${status_value}
    Wait Until Page Contains    ${status_value}
    Press Keys    ${OPPORTUNITY_STATUS_FIELD}    RETURN
    Set Suite Variable    ${CURRENT_OPPORTUNITY_IDENTIFIER}    Auto Opportunity ${title_suffix} ${timestamp}
    Set Suite Variable    ${CURRENT_QUOTE_TYPE}    ${quote_type}
    Set Suite Variable    ${CURRENT_TERM_MONTHS}    ${term_months}

Save Opportunity Draft
    Click Button    ${OPPORTUNITY_SAVE_BUTTON}
    Wait Until Page Contains    ${CURRENT_OPPORTUNITY_IDENTIFIER}    ${DEFAULT_TIMEOUT}

Create Quote For Current Opportunity
    [Arguments]    ${quote_type}
    Wait Until Element Is Visible    ${QUOTE_SUBTABS_MENU}    ${DEFAULT_TIMEOUT}
    Click Element    ${QUOTE_SUBTABS_MENU}
    Wait Until Element Is Visible    ${QUOTE_NEW_BUTTON}    ${DEFAULT_TIMEOUT}
    Click Button    ${QUOTE_NEW_BUTTON}
    Wait Until Element Is Visible    ${QUOTE_TYPE_DROPDOWN}    ${DEFAULT_TIMEOUT}
    Populate Quote Details    ${quote_type}
    Submit Quote

Populate Quote Details
    [Arguments]    ${quote_type}
    Input Text    ${QUOTE_TYPE_DROPDOWN}    ${quote_type}
    Press Keys    ${QUOTE_TYPE_DROPDOWN}    RETURN
    ${today}=    Get Time    result_format=%m/%d/%Y
    Input Text    ${QUOTE_START_DATE_FIELD}    ${today}
    ${term_months}=    Get From Dictionary    ${QUOTE_TYPE_METADATA}    ${quote_type}.term_months
    ${end_date}=    Evaluate    datetime.datetime.strptime(r"${today}", "%m/%d/%Y") + relativedelta.relativedelta(months=${term_months})    modules=datetime, dateutil.relativedelta
    ${end_date_str}=    Evaluate    ${end_date}.strftime("%m/%d/%Y")
    Input Text    ${QUOTE_END_DATE_FIELD}    ${end_date_str}

Submit Quote
    Click Button    ${QUOTE_SUBMIT_BUTTON}
    Wait Until Page Contains Element    ${QUOTE_CONFIRMATION_MESSAGE}    ${DEFAULT_TIMEOUT}
    ${confirmation}=    Get Text    ${QUOTE_CONFIRMATION_MESSAGE}
    Should Contain    ${confirmation}    Quote

Validate Quote Created Successfully
    [Arguments]    ${quote_type}
    Should Be Equal    ${CURRENT_QUOTE_TYPE}    ${quote_type}
    Wait Until Page Contains    ${quote_type}    ${DEFAULT_TIMEOUT}
    Wait Until Page Contains    ${CURRENT_OPPORTUNITY_IDENTIFIER}    ${DEFAULT_TIMEOUT}

Close Browser Session
    Run Keyword And Ignore Error    Close All Browsers
