require 'selenium-webdriver'

def login(driver, username, password)
  sleep(2)

  driver.find_element(:id, 'user-name').send_keys(username)
  sleep(1)
  driver.find_element(:id, 'password').send_keys(password)
  sleep(1)
  driver.find_element(:id, 'login-button').click

  sleep(2)
  
  begin
    driver.find_element(:class, 'shopping_cart_link')
    puts "------------------------"
    puts "Login successful"
  rescue StandardError => e
    raise "Login failed with \nLogin: \"#{username}\"\nPassword: \"#{password}\": #{e.message}"
  end
end

def logout(driver)
  driver.find_element(:id, 'react-burger-menu-btn').click
  sleep(2)
  driver.find_element(:id, 'logout_sidebar_link').click
  sleep(2)
end

def add_item_to_cart(driver, index)
  items = driver.find_elements(:class, 'inventory_item')

  puts "------------------------"
  if index < items.size
    items[index].find_element(:class, 'btn_inventory').click
    puts "Add to cart button clicked for item with index #{index}"
    sleep(2)
  else
    raise "Item with index #{index} not found"
  end
end

def cart_item_count(driver)
  cart_badge = driver.find_elements(:class, 'shopping_cart_badge')
  cart_badge.empty? ? 0 : cart_badge[0].text.to_i
end

def empty_cart(driver)
  driver.find_element(:class, 'shopping_cart_link').click
  sleep(2)
  cart_items = driver.find_elements(:class, 'cart_item')

  cart_items.each do | item |
    item.find_element(:class, 'cart_button').click
    sleep(2)
  end

  item_count = cart_item_count(driver)
  puts "------------------------"
  if item_count == 0
    puts "Cart successfull emptied"
  else
    raise "After clear the cart, #{item_count} items remain"
  end
end
