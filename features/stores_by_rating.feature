Feature: search for stores by rating

  As a student
  So that I can find the best rated restaurants/stores in the area
  I want to include and search by rating in stores I enter
  I also want to be able to sort my searches

Background: stores in database

  Given the following stores exist:
  | name                    | rating | description  |
  | McBonalds                 | 1      | Burger and fries  |
  | KingBurger          | 2      | fries and burger  |
  | The Krusty Krab    | 3      | spongebob fav place to eat  |
  | Cranberry Juice                | 4      | best juice in the world  |
  | Gong Cha                | 4      | nice boba   |
  | Some Pastry Shop                  | 2      | nice pastries  |
  | Btarsucks   | 4      | yummy coffee   |
  | Popsicles         | 2      | cooling popsicles   |
  | Chicken Wings | 3      | krispy  |
  | Energy Drinks            | 4      | caffeine drinks  |
  | Hotdog Stand           | 2      | ketchup and mustard  |

    And I am on the HoneyBunch home page
    Then 11 seed stores should exist

Scenario: add rating to existing store
  When I go to the edit page for "Hotdog Stand"
  And  I fill in "Rating" with "2"
  And  I press "Update Store Info"
  Then the rating of "Hotdog Stand" should be "2"

Scenario: can't find similar stores if we don't know rating
  Given I am on the details page for "Hotdog Stand"
  Then  I should not see "5"
  When  I follow "Find Stores With Same Rating"
  Then  I should be on the home page
  And   I should see "no rating info available"

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

Scenario: restrict to stores with '2' or '3' ratings
  When I check the following ratings: 2, 3
  And I uncheck the following ratings: 1, 4, 5
  And I press "Refresh"
  Then I should see "KingBurger"
  And I should see "The Krusty Krab"
  And I should see "Some Pastry Shop"
  And I should see "Popsicles"
  And I should see "Chicken Wings"
  And I should not see "McBonalds"
  And I should not see "Cranberry Juice"
  And I should not see "Gong Cha"
  And I should not see "Btarsucks"
  And I should not see "Energy Drinks"

Scenario: all ratings selected
  When I check the following ratings: 1, 2, 3, 4, 5
  And I press "Refresh"
  Then I should see all the stores