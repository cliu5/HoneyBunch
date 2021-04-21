Feature: search for stores by rating

  As a student
  So that I can find the best rated restaurants/stores in the area
  I want to include and search by category in stores I enter
  I also want to be able to sort my searches

Background: stores in database

  Given the following stores exist:
  | name                | rating | category    |description                  | menu           | image                                                                        | 
  | McBonalds           | 1      | Italian     |Burger and fries             | fries          | https://patch.com/img/cdn/users/22873889/2016/03/raw/20160356e2fa5dbf5fc.jpg |
  | KingBurger          | 2      | Italian     |fries and burger             | burger         | https://patch.com/img/cdn/users/22873889/2016/03/raw/20160356e2fa5dbf5fc.jpg |
  | The Krusty Krab     | 3      | Italian     |spongebob fav place to eat   | krabby patty   | https://patch.com/img/cdn/users/22873889/2016/03/raw/20160356e2fa5dbf5fc.jpg |
  | Cranberry Juice     | 4      | Drinks      |best juice in the world      | juice          | https://patch.com/img/cdn/users/22873889/2016/03/raw/20160356e2fa5dbf5fc.jpg |
  | Gong Cha            | 4      | Drinks      |nice boba                    | boba           | https://patch.com/img/cdn/users/22873889/2016/03/raw/20160356e2fa5dbf5fc.jpg |
  | Some Pastry Shop    | 2      | Cafe        |nice pastries                | croissant      | https://patch.com/img/cdn/users/22873889/2016/03/raw/20160356e2fa5dbf5fc.jpg |
  | Btarsucks           | 4      | Drinks      |yummy coffee                 | expresso       | https://patch.com/img/cdn/users/22873889/2016/03/raw/20160356e2fa5dbf5fc.jpg |
  | Popsicles           | 2      | Groceries   |cooling popsicles            | popsicles      | https://patch.com/img/cdn/users/22873889/2016/03/raw/20160356e2fa5dbf5fc.jpg |
  | Chicken Wings       | 3      | Italian     |krispy                       | fried chicken  | https://patch.com/img/cdn/users/22873889/2016/03/raw/20160356e2fa5dbf5fc.jpg |
  | Energy Drinks       | 4      | Cafe        |caffeine drinks              | monster energy | https://patch.com/img/cdn/users/22873889/2016/03/raw/20160356e2fa5dbf5fc.jpg |
  | Hotdog Stand        | 2      |             |ketchup and mustard          | hotdog         | https://patch.com/img/cdn/users/22873889/2016/03/raw/20160356e2fa5dbf5fc.jpg |
  And I am on the HoneyBunch home page
  When I create a temporary user and login
  Then 11 seed stores should exist
  And I should see "Search Local Columbia Stores"

Scenario: add rating to existing store
  When I go to the edit page for "Hotdog Stand"
  And  I fill in "Rating" with "2"
  And  I press "Update Store Info"
  Then the rating of "Hotdog Stand" should be "2"

Scenario: sort stores alphabetically
  When I follow "Store Name"
  Then I should see "Btarsucks" before "Chicken Wings"
  And I should see "McBonalds" before "Some Pastry Shop"
  And I should see "Some Pastry Shop" before "Energy Drinks"
  And I should see "Energy Drinks" before "Gong Cha"
  And I should see "Gong Cha" before "Chicken Wings"
  And I should see "Chicken Wings" before "Cranberry Juice"
  And I should see "Cranberry Juice" before "Popsicles"
  And I should see "Popsicles" before "KingBurger"
  And I should see "KingBurger" before "The Krusty Krab"

#Scenario: sort stores by their description
#  When I follow "Description"
#  Then I should see "Btarsucks" before "Chicken Wings"
#  And I should see "Chicken Wings" before "KingBurger"
#  And I should see "KingBurger" before "The Krusty Krab"
#  And I should see "The Krusty Krab" before "McBonalds"
 # And I should see "McBonalds" before "Energy Drinks"
 # And I should see "Energy Drinks" before "Gong Cha"
 # And I should see "Gong Cha" before "Some Pastry Shop"
 # And I should see "Some Pastry Shop" before "Popsicles"
 # And I should see "Popsicles" before "Cranberry Juice"

Scenario: restrict to stores with 'cafe' or 'drinks' categories
  When I check the following categories: Cafe, Drinks
  And I uncheck the following categories: Italian, Groceries
  And I press "Refresh"
  Then I should see "Some Pastry Shop"
  And I should see "Energy Drinks"
  And I should see "Cranberry Juice"
  And I should see "Gong Cha"
  And I should see "Btarsucks"
  And I should not see "McBonalds"
  And I should not see "KingBurger"
  And I should not see "The Krusty Krab"
  And I should not see "Popsicles"
  And I should not see "Chicken Wings"

Scenario: all categories selected:
  When I check the following categories: Cafe, Italian, Drinks, Chinese, Groceries
  And I press "Refresh"
  Then I should see all the stores
  
Scenario Outline: searching for a store/category/item that exists
  When I fill in "search_bar" with "<Query>"
  And I press "search_btn"
  Then I should see "<Store>"
  And I should not see "<NoSeeStore>"
  And I should not see "Your search query found no results :("
  Examples: 
    | Query        | Store           | NoSeeStore |
    | McBonalds    | McBonalds       | Gong Cha   |
    | Drinks       | Gong Cha        | McBonalds  |
    | juice        | Cranberry Juice | McBonalds  |
  
Scenario: searching for a store that doesn't exist
  When I fill in "search_bar" with "WeeeeAaaaaaaa"
  And I press "search_btn"
  Then I should see "McBonalds"
  And I should see "KingBurger"
  And I should see "The Krusty Krab"
  And I should see "Your search query found no results :("
  
Scenario: inputting nothing into the search bar
  When I fill in "search_bar" with ""
  And I press "search_btn"
  Then I should see "McBonalds"
  And I should see "KingBurger"
  And I should see "The Krusty Krab"
  And I should see "Please input a search query!"
  
Scenario: testing the order modal
  When I follow "McBonalds_order_link"
  And I press "order_btn"
  Then I should see "Address"
  
Scenario: cancelling an order
  When I follow "McBonalds_order_link"
  And I follow hidden "cancel_order_btn2"
  Then I should see "Search Local Columbia Stores"

Scenario Outline: placing an order and verifying it
  When I follow "<Store>_order_link"
  And I enter a hidden test address
  And I choose "<Item>" from hidden "<Store>_menu_dropdown2"
  And I press the hidden "order_confirm_btn2
  And I go to the HoneyBunch home page
  And I follow "my_orders_link"
  And I should see "Items you ordered"
  Then I should see "<Store>"
  Examples: 
    | Store        | Item   | 
    | McBonalds    | fries  |
    | KingBurger   | burger | 
    | Gong Cha     | boba   | 

Scenario Outline: receiving a delivery
  Given An order of "<Item>" has already been placed from "<Store>"
  When I follow "my_orders_link"
  And I follow "<Item>_receive_btn"
  Then I should not see "Received"
  And I should see "Order Again"
  Examples: 
    | Store     | Item   | 
    | McBonalds    | fries  |
    | KingBurger   | burger | 
    | Gong Cha     | boba   | 
    
Scenario Outline: accepting a delivery
  Given An order of "<Item>" has already been placed from "<Store>"
  When I follow "my_deliveries_link"
  And I follow "<Item>_accept_order_btn"
  Then I should not see "<Item>"
  And My order should say "delivering" in My Orders
  Examples: 
    | Store     | Item   | 
    | McBonalds    | fries  |
    | KingBurger   | burger | 
    | Gong Cha     | boba   | 

Scenario: logging out and logging back in
  When I follow "logout_link"
  And I try logging back into the temp user
  Then I should see "Search Local Columbia Stores"

Scenario: logging out and logging back in with invalid user
  When I follow "logout_link"
  And I try logging in with an invalid user
  Then I should see "Food Delivery Made Easy!"
  And I should see "Invalid username or password"
