Given /^I am on "(.*?)" page$/ do |arg1|
  visit arg1
end
Given /I ensure the confirm box returns OK/ do
  page.evaluate_script('window.confirm = function() { return true; }')
end
Given /^I am logged in as a user$/ do
  sign_in
end

