*** Settings ***
Documentation     Front-end regression checks for the public XPath Consulting website.
Resource          ../resources/XPathConsultingResource.robot
Suite Setup       Open XPath Consulting Homepage
Suite Teardown    Close All Browsers Safely
Test Setup        Reset Browser Scroll Position

*** Test Cases ***
Header Navigation Lists Main Sections
    [Tags]    smoke    navigation
    Validate Navigation Menu Items

Header Displays Contact Email Link
    [Tags]    smoke    header
    Header Contact Email Should Be    ${HEADER_EMAIL}

About Section Highlights Company Mission
    [Tags]    content    about
    Scroll To Element    css:#comp-lcumiuof
    Element Text Should Contain All    css:#comp-lcumiuof    SOBRE
    Element Text Should Contain All    css:#comp-lcumiuok    XPath Consulting    15 anos    100% nacional

Services Section Describes QA Value
    [Tags]    content    services
    Scroll To Element    css:#comp-kl6jboo34
    Element Text Should Contain All    css:#comp-kl6jboo34    IMPORT
    Element Text Should Contain All    css:#comp-kl6jboo35    desenvolvimento de novas    consultoria especializada    DevOps    ciclo de

Areas De Atuacao Section Shows CTA
    [Tags]    content    portfolio
    Scroll To Element    css:#comp-ldp05o8a
    Element Text Should Contain All    css:#comp-ldp05o8a    Atua
    Element Text Should Contain All    css:#comp-ldp05o8d2    Portif
    Wait Until Element Is Visible    css:#comp-ldp05o8e4 iframe

Contact Form Requires Mandatory Fields
    [Tags]    form    validation
    Submit Contact Form Without Required Fields
    Wait Until Keyword Succeeds    5x    1s    Contact Field Should Be Invalid    ${CONTACT_NAME_INPUT}
    Wait Until Keyword Succeeds    5x    1s    Contact Field Should Be Invalid    ${CONTACT_EMAIL_INPUT}

Footer Lists Social Media Links
    [Tags]    footer    social
    Validate Footer Social Links
