# === jem

# - - - - - - - - - - - - - - - - - - - -
Given(/^I am on the "(.*?)" page$/) do  |page_title|
  visit '/jems' # index is Jem Listing page
  page.should have_content(@page_title)
end

When(/^I follow the "(.*?)" link$/) do |link_name|
   click_link(@link_name)
end

When(/^I then follow the "Back" link$/) do 
   click_link(:Back)
end

Then(/^I should see the New jem form$/) do
  page.should have_content('New jem')
end

When(/^I fill in "(.*?)" with "(.*?)"$/) do |field_name, field_value|
  #TODO - Field name vs Field title
  fill_in 'jem_name', :with => @field_value
  @feature_jem = @field_value
  #puts @feature_jem + 'feature'
  #puts @field_value + 'feature'
end

When(/^I press the "Create Jem" button$/) do 
  #puts 'hiya'
  fill_in 'jem_name', :with => 'foobar'
  click_button "Create Jem"

end

Then(/^I should see "(.*?)"$/) do |message|
  page.should have_content(@message)
end

Then(/^I should be back on the "(.*?)" page$/) do  |page_title|
  page.should have_content(@page_title)
end
