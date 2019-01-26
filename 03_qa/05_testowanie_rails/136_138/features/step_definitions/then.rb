Then(/^page should have notice "(.*?)"$/) do |arg1|
  # puts page.body.inspect
  assert page.has_content?(arg1)
end
Then(/^page should not have notice "(.*?)"$/) do |arg1|
  assert !page.has_content?(arg1)
end
Then /^page should have elements by xpath "(.*)"$/ do |xpath|
  page.all(:xpath, xpath)  
end

