Feature: Creating jems
  In order to have jems to record notes about
  As a client
  I want to create them easily
  
  Scenario: Creating a jem
  Given I am on the homepage
  When I follow "New Jem"
  And I fill in "Name" with "foo_bar"
  And I press "Create Project"
  Then I should see "Project has been created."
# R3 in Action 3.2 p55
