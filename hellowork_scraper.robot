*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem

*** Variables ***
${BROWSER}        Chrome
${LOGIN_URL}      https://www.hellowork.com/fr-fr/connexion
${HELLOWORK_EMAIL}    %{HELLOWORK_EMAIL}
${HELLOWORK_PASSWORD} %{HELLOWORK_PASSWORD}

*** Test Cases ***
Login To Hellowork
    Open Browser    ${LOGIN_URL}    ${BROWSER}    options=add_argument("--headless")
    Wait Until Element Is Visible    xpath=//input[@name="email"]    10s
    Input Text    xpath=//input[@name="email"]    ${HELLOWORK_EMAIL}
    Input Password    xpath=//input[@name="password"]    ${HELLOWORK_PASSWORD}
    Click Button    xpath=//button[contains(text(),"Connexion")]
    Wait Until Page Contains    Tableau de bord    15s
    Log To Console    ✅ Connexion réussie
