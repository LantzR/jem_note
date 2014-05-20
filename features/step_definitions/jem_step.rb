Given(/^I am on the "(.*?)" page$/) do  |page_title|
  visit '/jems' # index is Jem Listing page
  page.should have_content(@page_title)
end

When(/^I follow the "(.*?)" link$/) do |link_name|
   click_link(@link_name)
end

Then(/^I should see the New jem form$/) do
  page.should have_content('New jem')
end

When(/^I fill in "(.*?)" with "(.*?)"$/) do |field_name, field_value|
  #TODO - Field name vs Field title
  fill_in 'jem_name', :with => @field_value
end

When(/^I press the "(.*?)" button$/) do |button_name|
  click_button(@button_name)
end

Then(/^I should see "(.*?)"$/) do |message|
  page.should have_content(@message)
end

Then(/^I should be back on the "(.*?)" page$/) do  |page_title|
  page.should have_content(@page_title)
end
