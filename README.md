# Robot Framework Automation Examples for The Internet Herokuapp

[![API Tests Workflow](https://github.com/pragmatictesters/selenium-robot-framework/actions/workflows/robot-tests.yml/badge.svg)](https://github.com/pragmatictesters/selenium-robot-framework/actions/workflows/robot-tests.yml)

This repository contains automation examples using the **Robot Framework** with **SeleniumLibrary** for interacting with components on [The Internet Herokuapp](https://the-internet.herokuapp.com/). It demonstrates real-world automation scenarios including working with alerts, context menus, dynamic elements, login flows, and more.

---

## 📁 Folder Structure

```
robot-tests/
│
├── tests/                 # Test case files (.robot)
├── resources/             # Page objects, keywords, and images
├── test_data/             # Input data or supporting files
├── results/               # Test execution reports and logs
├── .gitignore
└── README.md
```

---

## 🛠️ Setup Instructions

### 1. Install Python (Recommended: Python 3.8+)

You can download Python from [python.org](https://www.python.org/downloads/). Make sure to check **"Add Python to PATH"** during installation.

### 2. Install Robot Framework and SeleniumLibrary

```bash
pip install robotframework
pip install robotframework-seleniumlibrary
```

### 3. Install WebDriver (ChromeDriver)

Ensure Chrome is installed and download the corresponding **ChromeDriver** from:
[https://sites.google.com/chromium.org/driver/](https://sites.google.com/chromium.org/driver/)

Place the driver in a folder that's in your system `PATH`.

Alternatively, you can use `webdriver-manager`:

```bash
pip install webdriver-manager
```

### 4. Install VS Code or PyCharm (Optional but recommended)

- **VS Code**: Install the "Robot Framework Language Server" extension.


---

## ▶️ Running Tests

### Run all test cases

```bash
robot tests/
```

### Run a specific test suite

```bash
robot tests/test_login.robot
```

### Run with output directory

```bash
robot -d results tests/
```

---

## 🌐 Components Automated

Examples cover components such as:

- Add/Remove Elements
- Alerts & Modal Dialogs
- Context Menu
- Login & Error Handling
- Dynamic Controls
- File Uploads
- Frames & Windows
- JavaScript Alerts
- and more...

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

## 📷 Screenshots & Assets

All visual assets and test data are stored under `resources/` and `test_data/` directories.


---

## 🧠 Author

**Janesh Kodikara** 

```
