Feature: search for stores by rating

  As a student
  So that I can find the best rated restaurants/stores in the area
  I want to include and search by rating in stores I enter

Background: stores in database

  Given the following stores exist:
  | name               | rating   | description |
  | Aladdin            | G        | 25-Nov-1992 |
  | Chicken Run        | G        | 21-Jun-2000 |
  | Spirited Away      |          | 31-Aug-2002 |
  | The Incredibles    | PG       | 5-Nov-2004  |  

Scenario: add rating to existing store
  When I go to the edit page for "Spirited Away"
  And  I fill in "Rating" with "PG-13"
  And  I press "Update Store Info"
  Then the rating of "Spirited Away" should be "PG-13"

Scenario: find stores with same rating
  Given I am on the details page for "Aladdin"
  When  I follow "Find Stores With Same Rating"
  Then  I should be on the Similar Stores page for "Aladdin"
  And   I should see "Chicken Run"
  But   I should not see "The Incredibles"

Scenario: can't find similar movies if we don't know director (sad path)
  Given I am on the details page for "Spirited Away"
  Then  I should not see "PG-13"
  When  I follow "Find Stores With Same Rating"
  Then  I should be on the home page
  And   I should see "no rating info availible"
