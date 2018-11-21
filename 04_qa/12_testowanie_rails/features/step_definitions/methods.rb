def set_selenium_window_size(width, height)
  window = Capybara.current_session.driver.browser.manage.window
  window.resize_to(width, height)
end


def select_something(where, what)
  option_xpath = "//select[@id='#{where}']/option[text()='#{what}']"
  option = page.first(:xpath, option_xpath).text
  select(option, :from => where)
end


def sign_in
  u = User.first
  if u.blank? then
    u = User.new
    u.email = "michalasobczak@gmail.com"
    u.password = "abc123!"
    u.save!
  end
  visit '/'
  fill_in 'user[email]', :with => 'michalasobczak@gmail.com'
  fill_in 'user[password]', :with => 'abc123!'
  click_button 'Sign in'
end



