from selenium import webdriver
from selenium.webdriver.common.by import By
import time

# Set up the Chrome driver
driver = webdriver.Chrome()  # make sure chromedriver is in PATH

# Open Google
driver.get("https://www.google.com")

# Wait for page to load
time.sleep(2)

# Type something into the search box
search_box = driver.find_element(By.NAME, "q")
search_box.send_keys("Hello from Selenium and Python!")
search_box.submit()

# Wait to see the result
time.sleep(5)

# Close the browser
driver.quit()