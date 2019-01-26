When /^I press "(.*?)"$/ do |arg1|
  click_button(arg1)
end


When /^I click on "(.*?)"$/ do |arg1|
  find("##{arg1}").click  
end


When /^I fill in "(.*?)" with "(.*?)"$/ do |arg1, arg2|
  fill_in arg1, :with => arg2
end


When /^I fill in "(.*?)" with "(.*?)" using JS$/ do |arg1, arg2|
  page.evaluate_script("$('##{arg1}').val('#{arg2}')") 
end


When /^I click link "(.*?)"$/ do |arg1|
  click_link arg1
end


When /^next to "(.*?)" I press "(.*?)"$/ do |arg1, arg2|
  xpath = "//td[normalize-space()='#{arg1}']/..//input[@value='#{arg2}']"
  page.all(:xpath, xpath).first.click
end


When /^I click by xpath "(.*?)"$/ do |xpath|
  page.all(:xpath, xpath).first.click
end


When /^I press key "(.*?)" on "(.*?)"$/ do |key,id|
  key_int = key.to_i
  #page.evaluate_script("var e = $.Event('keydown', { keyCode:#{key_int} }); $('##{id}').trigger(e);")
  page.find("##{id}").native.send_keys key.to_sym
end


When /^I select "(.*?)" with "(.*?)"$/ do |arg1, arg2|
  option_xpath = "//select[@id='#{arg1}']/option[text()='#{arg2}']"
  option = find(:xpath, option_xpath).text
  select(option, :from => arg1)
end


When /^I wait for "(.*?)" seconds$/ do |seconds|
  sleep(seconds.to_i)
end


When /^I set today at "(.*?)"$/ do |arg1|
  page.all("input[name='#{arg1}']").first.set(Date.today.to_s)
  page.all("input[name='#{arg1}']").last.set(Date.today.to_s)
end
