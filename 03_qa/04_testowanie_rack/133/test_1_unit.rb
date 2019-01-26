ENV['RACK_ENV'] = 'test'
require_relative 'hello_world'
require 'test/unit'
require 'rack/test'
class HelloWorldTest < Test::Unit::TestCase
  include Rack::Test::Methods
  def app
    Sinatra::Application
  end # app
  def test_it_says_hello_world
    get '/'
    assert last_response.ok?
    assert_equal 'Hello World', last_response.body
  end # test_it_says_hello_world
  def test_it_says_hello_to_a_person
    get '/', :name => 'Michal'
    assert last_response.body.include?('Michal')
  end # test_it_says_hello_to_a_person
end # HelloWorldTest

