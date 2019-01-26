require 'rubygems'
require 'bundler/setup'
require 'rack/test'
require 'minitest/autorun'
load 'app_proxy.rb'
class RackProxyTestSuite < MiniTest::Test
  include Rack::Test::Methods
  def app()
    AppProxy.new
  end # app
  def test_success
    get "/", nil, { "SERVER_NAME" => "rack.home.lab" }
    assert_equal (last_response.status).to_i, 200
  end # test_success
  def test_no_backend_available
    begin
      get "/", nil, { "SERVER_NAME" => "no-backend.home.lab" }
      assert_equal (last_response.status).to_i, 200
    rescue Exception => e    
      assert_equal "!: no backend available", e.to_s
    end
  end # test_no_backend_available
end # RackProxyTestSuite

