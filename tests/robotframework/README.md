# XPath Consulting Front-End Tests

This folder contains Robot Framework end-to-end checks that cover the main public features published on [xpathconsulting.com.br](https://www.xpathconsulting.com.br/).

## Prerequisites
- Python 3.10+ with `pip`
- A Chromium-based browser (Google Chrome or Microsoft Edge) or Firefox
- Corresponding WebDriver available on your `PATH` (e.g. `chromedriver`, `msedgedriver`, or `geckodriver`)

Install the Python dependencies:

```bash
pip install robotframework robotframework-seleniumlibrary webdriver-manager
```

> Tip: If you manage browsers with tools such as Selenium Manager or WebDriver Manager, ensure the driver binary is downloaded before running the suite.

## Executing the suite
From the repository root:

```bash
robot -d reports tests/robotframework/suites/xpathconsulting_frontend.robot
```

To run in headless mode (recommended for CI), switch the browser with a variable:

```bash
robot -d reports -v BROWSER:headlesschrome tests/robotframework/suites/xpathconsulting_frontend.robot
```

You can target a different environment (for example, a staging domain) by passing `BASE_URL`:

```bash
robot -d reports -v BASE_URL:https://staging.xpathconsulting.com.br/ tests/robotframework/suites/xpathconsulting_frontend.robot
```

## Test coverage
The suite validates:
- Header navigation links, contact email, and social icons
- Company “Sobre” section content
- Services value proposition and portfolio CTA
- Contact form required-field validation
- Footer social media destinations

Artifacts (logs, reports, and screenshots) are written under the folder provided with `-d` (defaults to `output`). Adjust or extend tests by editing the resource file at `tests/robotframework/resources/XPathConsultingResource.robot`.
