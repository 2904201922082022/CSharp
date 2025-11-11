*** Settings ***
Library           SeleniumLibrary    timeout=10    implicit_wait=0.5
Library           Collections

*** Variables ***
${BASE_URL}                     https://www.xpathconsulting.com.br/
${BROWSER}                      chrome
${HEADER_EMAIL}                 contato@xpathconsulting.com.br
@{NAV_EXPECTED_LABELS}          Início    Áreas de atuação    Nossos clientes    Entre em contato    Trabalhe na XPATH
@{NAV_EXPECTED_URLS}            https://www.xpathconsulting.com.br    https://www.xpathconsulting.com.br/novidades    https://www.xpathconsulting.com.br/sobre    https://www.xpathconsulting.com.br/entre-em-contato    https://www.xpathconsulting.com.br/c%C3%B3pia-entre-em-contato
&{FOOTER_SOCIAL_LINKS}          dataItem-lcxero9z1-comp-lcxero9h=https://www.linkedin.com/company/xpath-consulting/    dataItem-lcxero9z5-comp-lcxero9h=https://instagram.com/xpathconsulting?igshid=MDM4ZDc5MmU=    dataItem-lcxero9z7-comp-lcxero9h=https://www.facebook.com/profile.php?id=100089632055157&mibextid=ZbWKwL
${CONTACT_FORM_SUBMIT}          css:#comp-kl6jbr6j button
${CONTACT_NAME_INPUT}           css:#input_comp-kl6jbr50
${CONTACT_EMAIL_INPUT}          css:#input_comp-kl6jbr5k
${CONTACT_SUCCESS_MESSAGE}      css:#comp-kl6jbr6o1

*** Keywords ***
Open XPath Consulting Homepage
    [Documentation]    Launches the site in a browser and waits for the primary navigation to be available.
    Open Browser    ${BASE_URL}    ${BROWSER}
    Maximize Browser Window
    Wait Until Element Is Visible    css:#comp-kl6jbovh0label

Reset Browser Scroll Position
    [Documentation]    Ensures the viewport starts at the top of the page before each test.
    Execute Javascript    window.scrollTo(0, 0);

Close All Browsers Safely
    [Documentation]    Closes any browsers left open at the end of the suite.
    Run Keyword And Ignore Error    Capture Page Screenshot
    Close All Browsers

Scroll To Element
    [Arguments]    ${locator}
    Wait Until Page Contains Element    ${locator}
    ${element}=    Get Webelement    ${locator}
    Execute Javascript    arguments[0].scrollIntoView({behavior: 'instant', block: 'center'});    ${element}
    Sleep    0.5s

Validate Navigation Menu Items
    [Documentation]    Verifies that all top navigation entries are present with the expected href targets.
    ${count}=    Get Length    ${NAV_EXPECTED_LABELS}
    FOR    ${index}    IN RANGE    ${count}
        ${label}=    Get From List    ${NAV_EXPECTED_LABELS}    ${index}
        ${expected_href}=    Get From List    ${NAV_EXPECTED_URLS}    ${index}
        ${label_locator}=    Set Variable    css:#comp-kl6jbovh${index}label
        Wait Until Element Contains    ${label_locator}    ${label}
        ${link_locator}=    Set Variable    xpath=//li[@id='comp-kl6jbovh${index}']//a
        ${actual_href}=    Get Element Attribute    ${link_locator}    href
        Should Be Equal As Strings    ${actual_href}    ${expected_href}
    END

Header Contact Email Should Be
    [Arguments]    ${email}
    ${email_locator}=    Set Variable    css:#comp-lcxg8eq9 a
    Wait Until Element Is Visible    ${email_locator}
    Element Text Should Be    ${email_locator}    ${email}
    ${actual_href}=    Get Element Attribute    ${email_locator}    href
    Should Be Equal As Strings    ${actual_href}    mailto:${email}

Element Text Should Contain All
    [Arguments]    ${locator}    @{expected_fragments}
    Wait Until Element Is Visible    ${locator}
    ${text}=    Get Text    ${locator}
    FOR    ${fragment}    IN    @{expected_fragments}
        Should Contain    ${text}    ${fragment}
    END

Contact Field Should Be Invalid
    [Arguments]    ${locator}
    ${aria_invalid}=    Get Element Attribute    ${locator}    aria-invalid
    Should Be Equal As Strings    ${aria_invalid}    true

Validate Footer Social Links
    [Documentation]    Confirms that every social media icon points to the correct external destination.
    Scroll To Element    css:#comp-lcxero9h
    FOR    ${item_id}    ${expected_href}    IN    &{FOOTER_SOCIAL_LINKS}
        ${link_locator}=    Set Variable    css:li#${item_id} a
        Wait Until Element Is Visible    ${link_locator}
        ${actual_href}=    Get Element Attribute    ${link_locator}    href
        Should Be Equal As Strings    ${actual_href}    ${expected_href}
    END

Submit Contact Form Without Required Fields
    [Documentation]    Attempts to submit the contact form without entering mandatory fields.
    Scroll To Element    css:#comp-kl6jbr3t
    Click Button    ${CONTACT_FORM_SUBMIT}

