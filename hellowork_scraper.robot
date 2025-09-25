*** Settings ***
Library    SeleniumLibrary
Library    Collections
Library    OperatingSystem

*** Variables ***
${SEARCH_URLS}    https://www.hellowork.com/fr-fr/emplois?q=test+fonctionnel+manuel&remote=true
...               https://www.hellowork.com/fr-fr/emplois?q=intelligence+artificielle&remote=true

*** Test Cases ***
Scrape Remote Jobs QA And AI
    Open Browser    about:blank    headlesschrome
    FOR    ${url}    IN    @{SEARCH_URLS}
        Go To    ${url}
        Wait Until Page Contains Element    //article[contains(@class,"job-card")]    10s
        ${jobs}=    Get WebElements    //article[contains(@class,"job-card")]
        FOR    ${job}    IN    @{jobs}
            ${title}=    Get Text    xpath=.//h3
            ${company}=  Get Text    xpath=.//span[@class="company"]
            ${location}= Get Text    xpath=.//span[contains(@class,"location")]
            ${lang_ok}=  Run Keyword And Return Status    Should Match Regexp    ${title}    (?i)(QA|test|funcion|intelligence|IA)
            Run Keyword If    '${lang_ok}'=='True'    Log To Console    ${title} | ${company} | ${location}
        END
    END
    Close Browser
