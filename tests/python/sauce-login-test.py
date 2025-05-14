from selenium import webdriver
from selenium.webdriver.common.by import By
import time

# Set up Chrome driver
driver = webdriver.Chrome()  # Chromedriver should be in PATH

# Maximize window
driver.maximize_window()

# Go to Sauce Demo
driver.get("https://www.saucedemo.com/")

# Wait for page to load
time.sleep(2)

# Locate and fill in username
driver.find_element(By.ID, "user-name").send_keys("standard_user")

# Locate and fill in password
driver.find_element(By.ID, "password").send_keys("secret_sauce")

# Click login
driver.find_element(By.ID, "login-button").click()

# Wait to see result
time.sleep(3)

# Check if login successful by verifying URL or product page element
current_url = driver.current_url
if "inventory" in current_url:
    print("✅ Login Successful!")
else:
    print("❌ Login Failed.")

# Close browser
driver.quit()