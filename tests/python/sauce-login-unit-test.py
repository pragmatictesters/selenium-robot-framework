import unittest
from selenium import webdriver
from selenium.webdriver.common.by import By
import time

class SauceDemoLoginTest(unittest.TestCase):

    def setUp(self):
        # Set up Chrome driver
        chrome_options = webdriver.ChromeOptions()
        chrome_options.add_argument("--incognito")  # 👈 This enables incognito mode
        self.driver = webdriver.Chrome(options=chrome_options)
        self.driver.maximize_window()
        self.driver.get("https://www.saucedemo.com/")

    def tearDown(self):
        self.driver.quit()

    def test_login_valid_user(self):
        driver = self.driver
        driver.find_element(By.ID, "user-name").send_keys("standard_user")
        driver.find_element(By.ID, "password").send_keys("secret_sauce")
        driver.find_element(By.ID, "login-button").click()

        # Wait briefly (replace with WebDriverWait later)
        time.sleep(2)

        # Assert user is redirected to inventory page
        self.assertIn("inventory", driver.current_url)
        self.assertTrue(driver.find_element(By.CLASS_NAME, "inventory_list").is_displayed())

    def test_login_invalid_password(self):
        driver = self.driver
        driver.find_element(By.ID, "user-name").send_keys("standard_user")
        driver.find_element(By.ID, "password").send_keys("wrong_password")
        driver.find_element(By.ID, "login-button").click()
        time.sleep(2)
        # Assert error message is displayed
        error_message = driver.find_element(By.XPATH, "//h3[@data-test='error']")
        self.assertTrue(error_message.is_displayed())   
        self.assertEqual(error_message.text, "Epic sadface: Username and password do not match any user in this service")

    def test_login_with_blank_username_and_blank_password(self):
        driver = self.driver
        driver.find_element(By.ID, "user-name").clear()
        driver.find_element(By.ID, "password").clear()
        driver.find_element(By.ID, "login-button").click()
        time.sleep(2)
        # Assert error message is displayed
        error_message = driver.find_element(By.XPATH, "//h3[@data-test='error']")
        self.assertTrue(error_message.is_displayed())
        self.assertEqual(error_message.text, "Epic sadface: Username is required")


if __name__ == "__main__":
    unittest.main()