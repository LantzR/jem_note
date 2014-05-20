Feature: Creating jems
  In order to have jems to record notes about
  As a client
  I want to create jems easily
  
  Scenario: Creating a jem from "Listing jems" page
    Given I am on the "Listing jems" page
      When I follow the "New Jem" link
      Then I should see the New jem form
    When I fill in "Name" with "foo_bar"
      And I press the "Create Jem" button
      Then I should see "Jem was successfully created."
    When I follow the "Back" link
      Then I should be back on the "Listing jems" page
# R3 in Action 3.2 p55
