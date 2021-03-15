Feature: search for stores by rating

  As a student
  So that I can find the best rated restaurants/stores in the area
  I want to include and search by rating in stores I enter

Background: stores in database

  Given the following stores exist:
  | name                    | rating | description  |
  | Aladdin                 | G      | 25-Nov-1992  |
  | The Terminator          | R      | 26-Oct-1984  |
  | When Harry Met Sally    | R      | 21-Jul-1989  |
  | The Help                | PG-13  | 10-Aug-2011  |
  | Chocolat                | PG-13  | 5-Jan-2001   |
  | Amelie                  | R      | 25-Apr-2001  |
  | 2001: A Space Odyssey   | G      | 6-Apr-1968   |
  | The Incredibles         | PG     | 5-Nov-2004   |
  | Raiders of the Lost Ark | PG     | 12-Jun-1981  |
  | Chicken Run             | G      | 21-Jun-2000  |
  | Spirited Away           |        | 31-Aug-2002  |

    And I am on the RottenPotatoes home page
    Then 11 seed stores should exist

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
  And   I should see "no rating info available"

Scenario: sort stores alphabetically
  When I follow "Store Name"
  Then I should see "2001: A Space Odyssey" before "Raiders of the Lost Ark"
  And I should see "Aladdin" before "Amelie"
  And I should see "Amelie" before "Chicken Run"
  And I should see "Chicken Run" before "Chocolat"
  And I should see "Chocolat" before "Raiders of the Lost Ark"
  And I should see "Raiders of the Lost Ark" before "The Help"
  And I should see "The Help" before "The Incredibles"
  And I should see "The Incredibles" before "The Terminator"
  And I should see "The Terminator" before "When Harry Met Sally"
