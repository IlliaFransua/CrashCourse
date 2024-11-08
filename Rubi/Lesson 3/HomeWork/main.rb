require_relative 'functions'
require 'selenium-webdriver'

# Task 1
def test_add_three_items_to_cart(driver)
  login(driver, 'standard_user', 'secret_sauce')

  add_item_to_cart(driver, 0)
  add_item_to_cart(driver, 1)
  add_item_to_cart(driver, 4)

  item_count = cart_item_count(driver)
  puts "------------------------"
  if item_count == 3
    puts "3 items successfull added to the cart"
  else
    raise "Found #{item_count} items in the cart, but expected 3"
  end

  empty_cart(driver)
end

# Task 2
def test_blocked_login(driver)
  # Correct
  begin
    login(driver, 'standard_user', 'secret_sauce')
    sleep(2)
    logout(driver)

    login(driver, 'problem_user', 'secret_sauce')
    sleep(2)
    logout(driver)

    login(driver, 'performance_glitch_user', 'secret_sauce')
    sleep(2)
    logout(driver)

    login(driver, 'error_user', 'secret_sauce')
    sleep(2)
    logout(driver)

    login(driver, 'visual_user', 'secret_sauce')
    sleep(2)
    logout(driver)
  rescue StandardError => e
    raise "Failed to login with correct username and password: #{e.message}"
  end
  

  # Incorrect
  begin
    login(driver, 'incorrect_login', 'secret_sauce')
    sleep(2)
  rescue StandardError => e
    # We are ignoring it
  end
end

begin
  begin
    driver = Selenium::WebDriver.for :chrome
    driver.navigate.to "https://www.saucedemo.com"

    # Task 1
    test_add_three_items_to_cart(driver)
    logout(driver)
    puts "------------------------"
    puts "\tTask 1 completed successfull"

    # Task 2
    test_blocked_login(driver)
    puts "------------------------"
    puts "\tTask 2 completed successfull"
  rescue => e
    puts e.message
  end

ensure
  driver.quit
end
