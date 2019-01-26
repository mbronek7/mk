ENV['RACK_ENV'] = 'test'
require_relative 'hello_world'  
require 'capybara'
require 'capybara/dsl'
require 'test/unit'
class HelloWorldTest < Test::Unit::TestCase
  include Capybara::DSL
  Capybara.default_driver = :selenium
  def setup
    Capybara.app = Sinatra::Application.new
  end # setup
  def test_it_works
    visit '/'
    assert page.has_content?('Hello World')
  end # test_it_works
end # HelloWorldTest

