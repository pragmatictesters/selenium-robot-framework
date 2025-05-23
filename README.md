# Robot Framework Automation Examples (Selenium + API ) 

This project demonstrates the use of the Robot Framework for both Selenium-based web automation and API testing. It includes  example  test suites that showcase how Robot Framework can be  used to automate UI workflows and validate API endpoints. 

[![API Tests Workflow](https://github.com/pragmatictesters/selenium-robot-framework/actions/workflows/robot-tests.yml/badge.svg)](https://github.com/pragmatictesters/selenium-robot-framework/actions/workflows/robot-tests.yml)

[![Run Robot Framework API Tests in Docker](https://github.com/pragmatictesters/selenium-robot-framework/actions/workflows/robot-api-tests-docker.yml/badge.svg)](https://github.com/pragmatictesters/selenium-robot-framework/actions/workflows/robot-api-tests-docker.yml)


---
```
ROBOT-DEMO/
│
├── .github/               # GitHub-related workflows or configs
├── drivers/               # Browser drivers (e.g., chromedriver)
│   └── chromedriver
├── libraries/             # Custom Python or Robot libraries
├── resources/             # Resource files (keywords, variables)
├── test-data/             # Test input files (e.g., images, CSVs)
│   └── mandella-worldcup.jpeg
├── tests/                 # Robot Framework test cases
│   ├── api/               # API test cases
│   ├── examples/          # Sample or reference test cases
│   └── selenium/          # UI tests using Selenium
├── .gitignore             # Git ignore rules
├── log.html               # Robot test execution log
├── output.xml             # Robot test execution raw output
├── report.html            # Robot test execution summary report
└── README.md              # Project documentation
```
----

## 🛠️ Setup Instructions

### 1. Install Python (Recommended: Python 3.8+)

You can download Python from [python.org](https://www.python.org/downloads/). Make sure to check **"Add Python to PATH"** during installation.

### 2. Install Robot Framework and SeleniumLibrary

```bash
python -m pip install --upgrade pip
pip install setuptools                   # Required for FakerLibrary
pip install robotframework
pip install robotframework-seleniumlibrary
pip install robotframework-requests
pip install robotframework-faker
pip install Faker

```

### 3. Install WebDriver (ChromeDriver)

Ensure Chrome is installed and download the corresponding **ChromeDriver** from:
[https://sites.google.com/chromium.org/driver/](https://sites.google.com/chromium.org/driver/)

Place the driver in a folder that's in your system `PATH`.


### 4. Install VS Code or PyCharm (Optional but recommended)

- **VS Code**: Install the "Robot Framework Language Server" extension.

Here’s a clean and clear update for the **VS Code setup section** in your `README.md`:

---

### 🧩 VS Code Setup

Make sure to install the following extensions to enable full support for Robot Framework development:

* ✅ [**Robot Framework Language Server**](https://marketplace.visualstudio.com/items?itemName=robocorp.robotframework-lsp) — Syntax highlighting, code completion, and Robot language support.
* 🐍 [**Python**](https://marketplace.visualstudio.com/items?itemName=ms-python.python) — Required for running and debugging Python-based tools.
* 🐞 [**Python Debugger (debugpy)**](https://marketplace.visualstudio.com/items?itemName=ms-python.debugpy) — Enables debugging Python code used in custom libraries.
* 📏 [**Pylint**](https://marketplace.visualstudio.com/items?itemName=ms-python.pylint) — For linting Python files and maintaining code quality.

---

## ▶️ Running Tests

### Run all test cases

```bash
robot tests/
```

### Run a specific test suite

```bash
robot tests/selenium/test_login.robot
```

### Run with output directory

```bash
robot -d results tests/
```

---

## 🌐 Components Automated

You can revise the original section to reflect that your test automation suite now includes **API tests** in addition to Selenium-based **UI component tests**.

Here’s the updated version:

---

## 🌐 Components Automated

Our test suite includes both **UI** and **API** automation using **Selenium** and **Robot Framework** with **RequestsLibrary**. The automated components and features include:

### 🖥️ UI Components (Selenium)

* Add/Remove Elements
* Alerts & Modal Dialogs
* Context Menu
* Login & Error Handling
* Dynamic Controls
* File Uploads
* Frames & Windows
* JavaScript Alerts
* and more...

### 🔗 API Components (Robot Framework)

* User Login & Logout
* Create Contact with Static & Random Data (Faker)
* Validate Response Structure
* Field-by-field Response Validation
* Negative Testing (e.g., create after logout)

These API tests use:

* `RequestsLibrary` for HTTP interactions
* `FakerLibrary` for generating random, realistic test data
* Custom libraries and keywords for reusable components and test logic


---

## 🧪 Test Execution Reports

After running the tests, Robot Framework will generate:

- `report.html` – Summary of test execution
- `log.html` – Detailed logs
- `output.xml` – Raw result data

All located inside the `results/` directory.

---

## ✅ Best Practices

- Page Object style keyword definitions are stored in `resources/`.
- Common variables (e.g., `${URL}`, `${BROWSER}`, `${TIMEOUT}`) are stored in `variables.py`.
- Browser runs in incognito mode by default with additional ChromeOptions.

---



---

## 🧠 Author

**Janesh Kodikara** 

```
