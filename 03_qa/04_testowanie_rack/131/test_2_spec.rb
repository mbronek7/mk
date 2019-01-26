load 'application.rb'
require "rack/test"
describe Application do
  include Rack::Test::Methods
  context "get to /some/url" do
    let(:app) { Application.new }
    it "returns the status 200" do
      get "/some/url"
      expect(last_response.status).to eq 200
    end # it
    it "returns the body" do
      get "/some/url"
      expect(last_response.body).to eq "You have requested the path /some/url, using GET"
    end # it
  end # context
end # Application

