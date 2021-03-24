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
    Then 11 seed stores should exist

Scenario: add rating to existing store
  When I go to the edit page for "Hotdog Stand"
  And  I fill in "Rating" with "2"
  And  I press "Update Store Info"
  Then the rating of "Hotdog Stand" should be "2"

Scenario: can't find similar stores if we don't know category
  Given I am on the details page for "Hotdog Stand"
  Then  I should not see "cafe"
  When  I follow "Find Stores With Same Category"
  Then  I should be on the home page
  And   I should see "This feature has not been implemented yet!"

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

Scenario: sort stores by their description
  When I follow "Description"
  Then I should see "Btarsucks" before "Chicken Wings"
  And I should see "Chicken Wings" before "KingBurger"
  And I should see "KingBurger" before "The Krusty Krab"
  And I should see "The Krusty Krab" before "McBonalds"
  And I should see "McBonalds" before "Energy Drinks"
  And I should see "Energy Drinks" before "Gong Cha"
  And I should see "Gong Cha" before "Some Pastry Shop"
  And I should see "Some Pastry Shop" before "Popsicles"
  And I should see "Popsicles" before "Cranberry Juice"

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
